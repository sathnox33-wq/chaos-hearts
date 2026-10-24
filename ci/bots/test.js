// Multiplayer scenario against a vanilla server running the Chaos Hearts datapack: two vanilla-protocol clients
// (mineflayer) play while the script drives the server console and reads its log. Run by ci/server-test.sh.
//
//   node test.js main           full scenario
//   node test.js after-restart  checks that progress survived a server restart
//
// Every check prints PASS or FAIL. The process exits non-zero if any check failed.
'use strict'
const fs = require('fs')
const http = require('http')
const crypto = require('crypto')
const mineflayer = require('mineflayer')

const CONSOLE = process.env.CONSOLE_FIFO
const LOG = process.env.SERVER_LOG
const VERSION = process.env.MC_VERSION || '1.21.11'
const HEARTS = ['rage', 'speed', 'infernal', 'void', 'frozen', 'storm', 'blood', 'titan', 'celestial', 'corruption']
const results = []
const sleep = ms => new Promise(r => setTimeout(r, ms))

function logSize () { return fs.statSync(LOG).size }
function logSince (offset) {
  const fd = fs.openSync(LOG, 'r')
  const len = logSize() - offset
  const buf = Buffer.alloc(Math.max(0, len))
  fs.readSync(fd, buf, 0, buf.length, offset)
  fs.closeSync(fd)
  return buf.toString('utf8')
}

// Sends a console command and returns the log text it produced.
async function run (cmd, wait = 700) {
  const at = logSize()
  fs.appendFileSync(CONSOLE, cmd + '\n')
  await sleep(wait)
  return logSince(at)
}

async function score (holder, obj) {
  const out = await run(`scoreboard players get ${holder} ${obj}`, 400)
  const m = out.match(new RegExp(`${holder.replace('#', '\\#')} has (-?\\d+) \\[`))
  return m ? Number(m[1]) : null
}

async function registry () {
  const out = await run('function ch:admin/list', 900)
  return out.split('\n').map(l => l.match(/heart (\d+) (\w+) (\w+) holder (-?\d+) collector (-?\d+)/)).filter(Boolean)
    .map(m => ({ id: +m[1], type: m[2], state: m[3], holder: +m[4], collector: +m[5] }))
}

async function waitFor (fn, ms, step = 500) {
  const end = Date.now() + ms
  while (Date.now() < end) {
    try { if (await fn()) return true } catch (e) {}
    await sleep(step)
  }
  return false
}

function check (name, ok, detail) {
  results.push({ name, ok })
  console.log(`${ok ? 'PASS' : 'FAIL'}  ${name}${!ok && detail !== undefined ? '\n      ' + String(typeof detail === 'string' ? detail : JSON.stringify(detail)).trim().split('\n').slice(-8).join('\n      ') : ''}`)
}

function join (username) {
  return new Promise((resolve, reject) => {
    const bot = mineflayer.createBot({ host: '127.0.0.1', port: 25565, username, version: VERSION, auth: 'offline' })
    bot.packOffers = []
    bot.titles = []
    bot.on('title', (t) => { bot.titles.push((typeof t === 'string' ? t : JSON.stringify(t)).slice(0, 160)); if (bot.titles.length > 12) bot.titles.shift() })
    bot.titles = []
    bot.on('resourcePack', (url, hash) => { bot.packOffers.push({ url, hash }); try { bot.acceptResourcePack() } catch (e) {} })
    bot.on('title', (t) => bot.titles.push(String(t)))
    bot.once('spawn', () => resolve(bot))
    bot.once('kicked', r => reject(new Error(username + ' kicked: ' + JSON.stringify(r))))
    bot.once('error', reject)
    setTimeout(() => reject(new Error(username + ' did not spawn')), 60000)
  })
}

function fetch (url) {
  return new Promise((resolve, reject) => {
    http.get(url, res => {
      const chunks = []
      res.on('data', c => chunks.push(c))
      res.on('end', () => resolve({ status: res.statusCode, body: Buffer.concat(chunks) }))
    }).on('error', reject)
  })
}

// Holds sneak and taps a key for two ticks, the way a player triggers a Chaos Hearts hotkey.
// mineflayer only sends the sneak flag of the player_input packet, so the test sends the whole input state itself.
function input (bot, flags) {
  const inputs = { forward: false, backward: false, left: false, right: false, jump: false, shift: false, sprint: false }
  bot._client.write('player_input', { inputs: Object.assign(inputs, flags) })
}

const KEY = { back: 'backward', left: 'left', right: 'right', jump: 'jump', sprint: 'sprint', forward: 'forward' }

async function hotkey (bot, key, times = 1) {
  input(bot, { shift: true })
  await sleep(150)
  for (let n = 0; n < times; n++) {
    input(bot, { shift: true, [KEY[key]]: true })
    await sleep(110)
    input(bot, { shift: true })
    await sleep(120)
  }
  await sleep(150)
  input(bot, {})
  await sleep(200)
}

const dim = bot => String(bot.game.dimension || '')

async function arena () {
  for (const c of ['fill -12 99 -12 12 99 12 minecraft:stone', 'fill -12 100 -12 12 110 12 minecraft:air',
    'fill -3 99 37 3 99 43 minecraft:stone', 'fill -3 100 37 3 104 43 minecraft:air']) await run(c, 250)
}

async function main () {
  const attacker = await join('Attacker')
  await sleep(1500)
  const victim = await join('Victim')
  check('two players join with vanilla clients', true)
  await sleep(3000)
  for (const c of ['op Attacker', 'op Victim', 'gamemode survival Attacker', 'gamemode survival Victim', 'difficulty normal',
    'time set day', 'gamerule keep_inventory true', 'gamerule do_mob_spawning false', 'gamerule pvp true']) await run(c, 250)
  await arena()

  // ---- joining: a starting heart that is a real extra heart of health
  const aActive = await score('Attacker', 'ch.active')
  const vActive = await score('Victim', 'ch.active')
  check('each new player starts with a random Chaos Heart', aActive >= 1 && vActive >= 1, `attacker ${aActive}, victim ${vActive}`)
  let out = await run('attribute Attacker minecraft:max_health modifier value get ch:hearts')
  check('a held Chaos Heart adds a heart of max health', /is 2(\.0)?\b/.test(out), out)
  check('there is no Focus item', attacker.inventory.items().length === 0, attacker.inventory.items().map(i => i.name))

  const offer = victim.packOffers[0]
  check('the server offers the resource pack', !!offer, victim.packOffers)
  if (offer) {
    const res = await fetch(offer.url).catch(e => ({ status: 0, err: e }))
    const sha1 = res.body ? crypto.createHash('sha1').update(res.body).digest('hex') : ''
    check('the pack downloads and matches its SHA-1', res.status === 200 && sha1 === process.env.PACK_SHA1, `status ${res.status} ${sha1}`)
  }

  // ---- admin tools
  await run('function ch:admin/give {player:"Attacker",heart:"rage"}')
  await run('function ch:admin/give {player:"Victim",heart:"storm"}')
  await run('function ch:admin/mastery {player:"Attacker",heart:"rage",level:100}')
  check('admin can give hearts', (await score('Attacker', 'ch.cnt.rage')) >= 1 && (await score('Victim', 'ch.cnt.storm')) >= 1)
  check('admin can set mastery', (await score('Attacker', 'ch.lvl.rage')) === 100, await score('Attacker', 'ch.lvl.rage'))
  out = await run('attribute Attacker minecraft:max_health modifier value get ch:hearts')
  check('max health follows the hearts held', /is 4(\.0)?\b/.test(out) || aActive === 1, out)

  // ---- hotkeys: shuffle, then cast with sneak + jump
  // The starting heart is random; when it was rage the Attacker holds only one heart and has nothing to shuffle to.
  if (aActive === 1) await run('function ch:admin/give {player:"Attacker",heart:"speed"}')
  await run('execute as Attacker run function ch:heart/set_active {i:1}')
  await run('tp Attacker 0 100 0 0 0')
  await run('tp Victim 0 100 3 180 0')
  await sleep(800)
  const before = await score('Attacker', 'ch.active')
  let after = before
  for (let t = 0; t < 3 && after === before; t++) {
    await hotkey(attacker, 'back')
    after = await score('Attacker', 'ch.active')
    if (after === before) await sleep(2200)
  }
  check('sneak + back shuffles the active heart', after !== before && after >= 1, `${before} -> ${after}`)
  await run('scoreboard players set Attacker ch.swapcd 0')
  await run('execute as Attacker run function ch:heart/set_active {i:1}')
  await run('effect clear Victim')
  await run('scoreboard players set Attacker ch.cd1 0')
  const hpBefore = victim.health
  await run('tp Attacker 0 100 0 0 60')
  await sleep(300)
  await hotkey(attacker, 'jump')
  const cast = await waitFor(async () => (await score('Attacker', 'ch.cd1')) > 0, 4000)
  check('sneak + jump casts ability 1', cast)
  await waitFor(() => victim.health < hpBefore, 5000)
  check('Rage Leap (Earthsplitter, looking down) damages a player in front', victim.health < hpBefore, `victim health ${hpBefore} -> ${victim.health}`)
  await run('effect give Victim minecraft:instant_health 1 10')

  // ---- every ability of every heart, in each variant
  await run('effect give Victim minecraft:resistance 600 4 true')
  await run('effect give Attacker minecraft:resistance 600 4 true')
  const broken = []
  for (let i = 0; i < HEARTS.length; i++) {
    const h = HEARTS[i]
    await run(`function ch:admin/give {player:"Attacker",heart:"${h}"}`, 300)
    await run(`function ch:admin/mastery {player:"Attacker",heart:"${h}",level:100}`, 300)
    await run(`execute as Attacker run function ch:heart/set_active {i:${i + 1}}`, 300)
    for (let s = 1; s <= 4; s++) {
      let ok = 0
      for (const pitch of [0, -1.2, 1.2]) {
        await run('tp Attacker 0 100 0 0 0', 150)
        await run('tp Victim 0 100 4 180 0', 150)
        await run('scoreboard players set Attacker ch.cd1 0', 50)
        await run('scoreboard players set Attacker ch.cd2 0', 50)
        await run('scoreboard players set Attacker ch.cd3 0', 50)
        await run('scoreboard players set Attacker ch.cd4 0', 50)
        await attacker.look(Math.PI, pitch, true)
        await sleep(150)
        attacker.chat(`/trigger cast set ${s}`)
        if (await waitFor(async () => (await score('Attacker', `ch.cd${s}`)) > 0, 2500, 400)) ok++
        await sleep(1200)
      }
      if (ok === 0) broken.push(`${h} a${s}`)
      check(`${h} ability ${s} casts`, ok > 0, `${ok}/3 variants put it on cooldown`)
    }
    await run('kill @e[type=!player,distance=..60]', 300)
    await arena()
  }
  await run('effect clear Victim')
  await run('effect clear Attacker')
  await run('execute as Attacker run function ch:heart/set_active {i:1}')

  // ---- PvP kill: only the latest heart drops, only the killer can collect it
  // let lingering abilities from the cast checks run out first, so nothing else kills the victim
  await run('tp Victim 0 100 -40')
  await run('kill @e[type=!player,type=!marker,type=!item_display,type=!block_display,type=!text_display,type=!interaction]')
  await sleep(8000)
  await run('effect give Victim minecraft:instant_health 1 10')
  await run('function ch:admin/give {player:"Victim",heart:"titan"}')
  await run('tp Attacker 0 100 40')
  await run('tp Victim 0 100 0')
  await sleep(1200)
  const victimPid = await score('Victim', 'ch.pid')
  const attackerPid = await score('Attacker', 'ch.pid')
  const droppedBefore = new Set((await registry()).filter(r => r.state === 'dropped').map(r => r.id))
  await run('damage Victim 1000 minecraft:player_attack by Attacker', 2500)
  let reg = await registry()
  const dropped = reg.filter(r => r.state === 'dropped' && !droppedBefore.has(r.id))
  check('a PvP death drops a heart for the killer', dropped.length === 1 && dropped[0].collector === attackerPid, reg)
  check('the heart that drops is the most recent one (titan)', dropped.length === 1 && dropped[0].type === 'titan', dropped)

  await waitFor(() => victim.health > 0 && victim.entity, 15000)
  await sleep(1500)
  await run('tp Victim 0 100 0')
  await sleep(3000)
  reg = await registry()
  check('the victim cannot pick their own heart back up', reg.some(r => r.type === 'titan' && r.state === 'dropped'), reg)
  await run('tp Victim 0 100 -8')
  await run('tp Attacker 0 100 0')
  const got = await waitFor(async () => (await registry()).some(r => r.type === 'titan' && r.state === 'held' && r.holder === attackerPid), 10000, 1000)
  check('the killer collects the heart by walking over it', got, await registry())
  check('the victim keeps their other hearts', (await registry()).some(r => r.state === 'held' && r.holder === victimPid), await registry())

  // ---- the Awakening Altar and a trial that is lost
  await run('execute as Attacker at @s run function ch:admin/altar/place', 1500)
  out = await run('execute if block 0 100 4 minecraft:barrier run say altar-barrier-ok')
  check('the altar is built from unbreakable blocks', /altar-barrier-ok/.test(out), out)
  out = await run('execute as Victim at @s run setblock 4 100 4 minecraft:air destroy')
  await run('scoreboard players set #trial_retry_min ch.cfg 0')
  await run('scoreboard players set Attacker ch.ctag 0')
  await run('item replace entity Attacker weapon.offhand with minecraft:air')
  await run('tp Attacker 0 102 1')
  await sleep(600)
  await run('execute as Attacker run function ch:heart/set_active {i:1}')
  attacker.chat('/trigger chmenu set 900')
  const inTrial = await waitFor(async () => (await score('Attacker', 'ch.trial')) >= 1 && /trials/.test(dim(attacker)), 15000, 700)
  check('a player at mastery 100 starts a trial at the altar', inTrial, `${await score('Attacker', 'ch.trial')} ${dim(attacker)} lvl ${await score('Attacker', 'ch.lvl')} titles ${attacker.titles.join(' | ')}`)
  const fighting = await waitFor(async () => (await score('#s0', 'ch.state')) >= 3, 40000, 1500)
  check('the arena builds and the fight begins after the intro', fighting, await score('#s0', 'ch.state'))
  out = await run('execute in ch:trials positioned 0 100 0 if entity @e[tag=ch.tmob,type=!#ch:ignore,distance=..90] run say trial-mobs-ok', 900)
  check('trial mobs spawn in the first wave', /trial-mobs-ok/.test(out), out)
  out = await run('execute if items entity Attacker weapon.offhand minecraft:totem_of_undying run say ward-ok')
  check('the challenger holds the Trial Ward', /ward-ok/.test(out), out)
  await run('damage Attacker 1000 minecraft:generic', 3000)
  const back = await waitFor(async () => (await score('Attacker', 'ch.trial')) === 0 && !/trials/.test(dim(attacker)), 15000)
  check('a lethal blow breaks the ward, fails the trial and sends the player home', back, dim(attacker))
  check('the player is alive after the failed trial', attacker.health > 0, attacker.health)
  check('the arena slot is free again', (await score('#s0', 'ch.state')) === 0)
  await sleep(2000)
  out = await run('execute in ch:trials positioned 0 100 0 if entity @e[tag=ch.tmob,distance=..120] run say leftover-mobs', 600)
  check('trial mobs are removed after the run', !/leftover-mobs/.test(out), out)

  // ---- every trial can be won
  for (let i = 0; i < HEARTS.length; i++) {
    const h = HEARTS[i]
    await run(`function ch:admin/mastery {player:"Attacker",heart:"${h}",level:100}`, 300)
    await run(`scoreboard players set Attacker ch.awk.${h} 0`, 100)
    await run(`execute as Attacker run function ch:heart/set_active {i:${i + 1}}`, 300)
    await run('scoreboard players set Attacker ch.ctag 0', 100)
    await run('item replace entity Attacker weapon.offhand with minecraft:air', 100)
    await run('tp Attacker 0 102 1', 600)
    attacker.chat('/trigger chmenu set 900')
    await sleep(1000)
    const started = await waitFor(async () => (await score('Attacker', 'ch.trial')) >= 1, 6000)
    // the bot cannot dodge, so it fights with heavy protection: this checks the trial's flow, not its difficulty
    for (const e of ['resistance 9999 4', 'fire_resistance 9999 0', 'regeneration 9999 4', 'saturation 9999 0']) await run(`effect give Attacker minecraft:${e} true`, 60)
    attacker.titles.length = 0
    const waves = await waitFor(async () => (await score('#s0', 'ch.state')) >= 3, 40000, 1500)
    let spawned = false
    const boss = await waitFor(async () => {
      const o = await run('execute in ch:trials positioned 0 100 0 if entity @e[tag=ch.tmob,type=!#ch:ignore,distance=..90] run say mobs-alive', 300)
      if (/mobs-alive/.test(o)) spawned = true
      const st = await score('#s0', 'ch.state')
      if (st === 3) await run('execute in ch:trials positioned 0 100 0 run kill @e[tag=ch.tmob,tag=!ch.boss,type=!#ch:ignore,distance=..90]', 300)
      return st >= 5
    }, 60000, 1500)
    await sleep(3000)
    // the boss must still be standing after its entrance; killing it then also proves it was there
    out = await run('execute in ch:trials positioned 0 100 0 run kill @e[tag=ch.boss,distance=..120]', 900)
    const bossAlive = /Killed /.test(out)
    const awake = await waitFor(async () => (await score('Attacker', `ch.awk.${h}`)) === 1, 8000)
    const home = await waitFor(async () => (await score('Attacker', 'ch.trial')) === 0, 15000)
    check(`the ${h} trial runs: waves, boss, awakening`, started && waves && spawned && boss && bossAlive && awake && home,
      { started, waves, spawned, boss, bossAlive, awake, home, titles: attacker.titles.slice(-6) })
    if (!home) { await run('function ch:trial/cleanup {s:0}'); await run('scoreboard players set Attacker ch.trial 0') }
  }

  // ---- menus and the skill tree
  await run('execute as Attacker run function ch:heart/set_active {i:1}')
  const pts = await score('Attacker', 'ch.pts.rage')
  attacker.chat('/trigger hearts')
  await sleep(500)
  attacker.chat('/trigger chmenu set 31')
  await sleep(800)
  check('awakening grants skill points', pts >= 3, pts)
  check('a skill node can be taken from the menu', (await score('Attacker', 'ch.tree.rage')) === 1, await score('Attacker', 'ch.tree.rage'))
  attacker.chat('/trigger chmenu set 39')
  await sleep(800)
  check('the first respec is free and refunds the tree', (await score('Attacker', 'ch.tree.rage')) === 0)

  // ---- the Eye
  await run('execute as Attacker at @s run function ch:eye/on', 1500)
  check('the admin becomes the Eye', (await score('Attacker', 'ch.eye')) === 1)
  out = await run('data get entity Attacker abilities.mayfly')
  check('the Eye can fly', /: 1b/.test(out), out)
  out = await run('execute as Attacker at @s if entity @e[type=item_display,tag=ch.eyeball,distance=..6] run say eye-model-ok')
  check('the Eye model follows the admin', /eye-model-ok/.test(out), out)
  const chat = []
  victim.on('messagestr', m => chat.push(m))
  await run('execute as Attacker at @s run function ch:eye/say {msg:"I see you, little one"}', 1200)
  check('the Eye speaks to players', chat.some(m => /little one/.test(m)), chat)
  const voidBefore = await score('Victim', 'ch.cnt.void') || 0
  await run('execute as Attacker at @s run function ch:eye/give {player:"Victim",heart:"void"}', 1500)
  check('the Eye gives a heart', (await score('Victim', 'ch.cnt.void')) === voidBefore + 1)
  await run('execute as Attacker at @s run function ch:eye/take {player:"Victim",heart:"void"}', 1500)
  check('the Eye takes a heart', (await score('Victim', 'ch.cnt.void')) === voidBefore)
  await run('execute as Attacker at @s run function ch:eye/off', 1500)
  check('the Eye can close again', (await score('Attacker', 'ch.eye')) === 0)

  // ---- combat logging drops the latest heart for the opponent
  await run('function ch:admin/give {player:"Victim",heart:"celestial"}')
  await run('tp Victim 0 100 -10')
  await run('tp Attacker 0 100 -7')
  await sleep(800)
  await run('damage Victim 2 minecraft:player_attack by Attacker', 800)
  const tagInfo = `victim ctag ${await score('Victim', 'ch.ctag')} opp ${await score('Victim', 'ch.opp')} attacker ctag ${await score('Attacker', 'ch.ctag')}`
  victim.quit()
  await sleep(2500)
  const victim2 = await join('Victim')
  await sleep(3000)
  reg = await registry()
  check('logging out in combat drops the latest heart', reg.some(r => r.type === 'celestial' && r.state === 'dropped' && r.collector === attackerPid), `${tagInfo} seen ${await score('Victim', 'ch.seen')} ${JSON.stringify(reg.slice(-3))}`)
  victim2.quit()
  await run('save-all', 1500)
  attacker.quit()
  await sleep(1000)
  void victimPid
}

async function afterRestart () {
  const attacker = await join('Attacker')
  await sleep(2500)
  check('mastery survives a server restart', (await score('Attacker', 'ch.lvl.rage')) === 100)
  check('awakening survives a server restart', (await score('Attacker', 'ch.awk.rage')) === 1)
  const reg = await registry()
  check('the heart registry survives a restart', reg.some(r => r.type === 'titan' && r.state === 'held'), reg)
  out = await run('attribute Attacker minecraft:max_health get')
  check('max health is still right after a restart', /is (\d+)/.test(out) && Number(out.match(/is (\d+)/)[1]) > 20, out)
  attacker.quit()
  await sleep(500)
}
let out

const phase = process.argv[2] || 'main'
;(phase === 'main' ? main() : afterRestart())
  .catch(e => check('scenario ran to the end', false, e.stack || e))
  .finally(() => {
    const failed = results.filter(r => !r.ok)
    console.log(`\n${results.length - failed.length}/${results.length} checks passed`)
    process.exit(failed.length ? 1 : 0)
  })
