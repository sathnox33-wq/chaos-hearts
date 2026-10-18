// Multiplayer scenario against a real server: two vanilla-protocol clients (mineflayer) play while
// the script drives the server console and reads its log. Run by ci/server-test.sh.
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
async function run (cmd, wait = 1200) {
  const at = logSize()
  fs.appendFileSync(CONSOLE, cmd + '\n')
  await sleep(wait)
  return logSince(at)
}

async function waitLog (re, ms, from) {
  const end = Date.now() + ms
  while (Date.now() < end) {
    if (re.test(logSince(from))) return true
    await sleep(250)
  }
  return false
}

async function waitFor (fn, ms, step = 250) {
  const end = Date.now() + ms
  while (Date.now() < end) {
    try { if (await fn()) return true } catch (e) {}
    await sleep(step)
  }
  return false
}

function check (name, ok, detail) {
  results.push({ name, ok })
  console.log(`${ok ? 'PASS' : 'FAIL'}  ${name}${!ok && detail ? '\n      ' + String(detail).trim().split('\n').slice(-6).join('\n      ') : ''}`)
}

function join (username) {
  return new Promise((resolve, reject) => {
    const bot = mineflayer.createBot({ host: '127.0.0.1', port: 25565, username, version: VERSION, auth: 'offline' })
    bot.chatLog = []
    bot.packOffers = []
    bot.on('messagestr', m => bot.chatLog.push(m))
    bot.on('actionBar', m => bot.chatLog.push(m.toString()))
    bot.on('resourcePack', (url, hash) => { bot.packOffers.push({ url, hash }); try { bot.acceptResourcePack() } catch (e) {} })
    bot.once('spawn', () => resolve(bot))
    bot.once('kicked', r => reject(new Error(username + ' kicked: ' + JSON.stringify(r))))
    bot.once('error', reject)
    setTimeout(() => reject(new Error(username + ' did not spawn')), 60000)
  })
}

function heldHearts (bot) {
  return bot.inventory.items().filter(i => i.name === 'heart_of_the_sea')
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

function dim (bot) { return String(bot.game.dimension || '') }

async function main () {
  const attacker = await join('Attacker')
  const victim = await join('Victim')
  check('two players join with vanilla clients', true)
  await sleep(3000)

  // ---- starting heart and the resource pack
  check('each new player receives a starting heart and its Focus',
    heldHearts(attacker).length >= 1 && heldHearts(victim).length >= 1,
    `attacker ${heldHearts(attacker).length}, victim ${heldHearts(victim).length}`)

  const offer = victim.packOffers[0]
  check('server offers the resource pack on join', !!offer, JSON.stringify(victim.packOffers))
  if (offer) {
    const res = await fetch(offer.url.replace(/^http:\/\/[^/:]+/, 'http://127.0.0.1')).catch(e => ({ status: 0, err: e }))
    const sha1 = res.body ? crypto.createHash('sha1').update(res.body).digest('hex') : ''
    const advertised = (logSince(0).match(/resource pack \(\d+ KB, sha1 ([0-9a-f]{40})\)/) || [])[1]
    check('pack download works and matches the advertised SHA-1', res.status === 200 && sha1 === advertised,
      `status ${res.status}, ${sha1} vs ${advertised}`)
  }

  for (const c of ['op Attacker', 'op Victim', 'gamemode survival Attacker', 'gamemode survival Victim',
    'difficulty normal', 'time set day',
    'fill -4 99 -4 4 99 4 minecraft:stone', 'fill -4 100 -4 4 104 4 minecraft:air', 'fill -2 99 58 2 99 62 minecraft:stone', 'fill -2 100 58 2 103 62 minecraft:air']) await run(c, 300)

  // ---- set up: the attacker owns a Rage heart at mastery 100, the victim gains a Storm heart last
  let out = await run('chaosadmin give Attacker rage force')
  await run('chaosadmin mastery Attacker rage set 100')
  out += await run('chaosadmin give Victim storm force')
  attacker.chat('/hearts equip rage')
  await sleep(1500)
  out += await run('chaosadmin inspect Attacker')
  check('admin can give hearts and set mastery', /Rage lvl 100/.test(out), out)

  // ---- an ability hits another player
  await run('tp Attacker 0 100 0 0 0')
  await run('tp Victim 0 100 3 180 0')
  await sleep(1000)
  // Before any heart has dropped, the only Heart of the Sea a player carries is their Focus.
  const focus = heldHearts(attacker)[0]
  if (focus) await attacker.equip(focus, 'hand').catch(() => {})
  attacker.chatLog.length = 0
  await run('effect clear Victim')
  const hpBefore = victim.health
  attacker.chat('/chaos cast 1')
  await waitFor(() => victim.health < hpBefore, 6000)
  check('Rage Leap damages a nearby player', victim.health < hpBefore, `victim health ${hpBefore} -> ${victim.health}`)
  check('the caster gets a hit indicator', attacker.chatLog.some(m => /HIT/.test(m)), attacker.chatLog.join(' | '))
  await run('chaosadmin cooldowns Attacker')
  await run('effect give Victim minecraft:instant_health 1 10')
  await sleep(1500)

  // ---- PvP kill: only the latest heart drops, only the killer can collect it
  await run('tp Attacker 0 100 60')
  await run('tp Victim 0 100 0')
  await sleep(1500)
  await run('damage Victim 1000 minecraft:player_attack by Attacker', 2500)
  out = await run('chaosadmin registry')
  check('a PvP death drops the heart for the killer', /Storm Heart dropped in minecraft:overworld .* for Attacker/.test(out), out)
  check('only the most recently acquired heart drops', (out.match(/dropped in/g) || []).length === 1, out)

  await waitFor(() => victim.health > 0 && victim.entity, 15000)
  await sleep(1500)
  await run('tp Victim 0 100 0')
  await sleep(3000)
  out = await run('chaosadmin registry')
  check('the victim cannot pick their own dropped heart back up', /Storm Heart dropped/.test(out), out)

  await run('tp Victim 0 100 -30')
  await run('tp Attacker 0 100 0')
  await waitFor(async () => /Storm Heart held by Attacker/.test(await run('chaosadmin registry', 600)), 10000, 1000)
  out = await run('chaosadmin registry')
  check('the killer collects the heart by walking over it', /Storm Heart held by Attacker/.test(out), out)
  out = await run('chaosadmin inspect Victim')
  check('the victim keeps their other hearts', /Hearts \(oldest first\): \S/.test(out), out)

  // ---- Awakening Trial: a death inside fails the run and returns the player unharmed
  await run('chaosadmin cooldowns Attacker')
  out = await run('chaosadmin trial start Attacker rage', 2000)
  check('the trial starts', /Started the trial for Attacker/.test(out), out)
  const inTrial = await waitFor(() => /chaoshearts:trials/.test(dim(attacker)), 15000)
  check('the challenger is moved to the trials dimension', inTrial, dim(attacker))
  const fighting = await waitFor(async () => /Rage Heart (WAVES|BOSS)/.test(await run('chaosadmin trial list', 500)), 60000, 2000)
  out = await run('chaosadmin trial list')
  check('the arena builds and the fight begins after the intro', fighting, out)
  const mobs = await waitFor(async () => /Test passed/.test(await run('execute in chaoshearts:trials if entity @e[tag=chaoshearts.trial]', 500)), 20000, 1000)
  check('trial mobs spawn in the first wave', mobs)

  await run('damage Attacker 1000 minecraft:generic', 3000)
  const back = await waitFor(() => !/chaoshearts:trials/.test(dim(attacker)), 15000)
  check('dying in a trial fails it and returns the player', back, dim(attacker))
  check('the player is alive after the failed trial', attacker.health > 0, attacker.health)
  out = await run('chaosadmin trial list')
  check('the failed session is closed', /Active trials \(0\)/.test(out), out)
  await sleep(4000)
  out = await run('execute in chaoshearts:trials if entity @e[tag=chaoshearts.trial]', 500)
  check('trial mobs are removed after the run', /Test failed/.test(out), out)

  out = await run('chaosadmin trial start Attacker rage', 2000)
  await waitFor(() => /chaoshearts:trials/.test(dim(attacker)), 15000)
  await sleep(3000)
  out = await run('chaosadmin trial win Attacker', 9000)
  await waitFor(() => !/chaoshearts:trials/.test(dim(attacker)), 20000)
  out = await run('chaosadmin inspect Attacker')
  check('winning the trial awakens the heart', /Rage lvl 100 .*awakened/.test(out), out)

  // ---- the Eye
  out = await run('execute as Attacker run eye on 4', 2000)
  victim.chatLog.length = 0
  attacker.chat('I see you, little one')
  await sleep(1500)
  check('the Eye speaks through chat', victim.chatLog.some(m => /THE EYE/.test(m) && /little one/.test(m)), victim.chatLog.join(' | '))
  out = await run('data get entity Attacker abilities.mayfly')
  check('the Eye can fly', /: 1b/.test(out), out)
  const voids = text => ((text.split('\n').find(l => /Hearts \(oldest/.test(l)) || '').match(/Void/g) || []).length
  const before = voids(await run('chaosadmin inspect Victim'))
  out = await run('execute as Attacker run eye give Victim void', 4000)
  const given = voids(await run('chaosadmin inspect Victim'))
  check('the Eye gives a heart', given === before + 1, out)
  out = await run('execute as Attacker run eye take Victim void', 6000)
  const taken = voids(await run('chaosadmin inspect Victim'))
  check('the Eye takes a heart', taken === before, out)
  await run('execute as Attacker run eye off', 1500)

  // ---- combat logging drops the latest heart
  await run('chaosadmin give Victim titan force')
  await run('tp Victim 0 100 0')
  await run('tp Attacker 0 100 3')
  await sleep(800)
  await run('damage Victim 2 minecraft:player_attack by Attacker', 800)
  victim.quit()
  await sleep(2500)
  out = await run('chaosadmin registry')
  check('logging out in combat drops the latest heart', /Titan Heart dropped .* for Attacker/.test(out), out)

  out = await run('chaosadmin save')
  attacker.quit()
  await sleep(1000)
}

async function afterRestart () {
  const attacker = await join('Attacker')
  await sleep(2000)
  const out = await run('chaosadmin inspect Attacker')
  check('progress survives a server restart', /Rage lvl 100 .*awakened/.test(out), out)
  const reg = await run('chaosadmin registry')
  check('the heart registry survives a restart', /Storm Heart held by Attacker/.test(reg), reg)
  attacker.quit()
  await sleep(500)
}

const phase = process.argv[2] || 'main'
;(phase === 'main' ? main() : afterRestart())
  .catch(e => check('scenario ran to the end', false, e.stack || e))
  .finally(() => {
    const failed = results.filter(r => !r.ok)
    console.log(`\n${results.length - failed.length}/${results.length} checks passed`)
    process.exit(failed.length ? 1 : 0)
  })
