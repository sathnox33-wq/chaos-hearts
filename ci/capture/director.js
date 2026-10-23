// Films Chaos Hearts in a real 1.21.11 client: a mineflayer bot ("Caster") casts every ability variant while the
// real client ("Cam", spectating, HUD hidden) follows it, and ffmpeg records the Xvfb screen. Run by capture.sh.
'use strict'
const fs = require('fs')
const path = require('path')
const { spawn, execFileSync } = require('child_process')
const mineflayer = require('mineflayer')

const CONSOLE = process.env.CONSOLE_FIFO
const LOG = process.env.SERVER_LOG
const OUT = process.env.CAPTURE_OUT
const DISPLAY = process.env.DISPLAY || ':99'
const SIZE = process.env.CAPTURE_SIZE || '1280x720'
const ONLY = (process.env.CAPTURE_HEARTS || '').split(',').filter(Boolean)
const HEARTS = ['rage', 'speed', 'infernal', 'void', 'frozen', 'storm', 'blood', 'titan', 'celestial', 'corruption']
const VARIANTS = [{ name: 'level', pitch: 0 }, { name: 'up', pitch: -60 }, { name: 'down', pitch: 60 }]
const sleep = ms => new Promise(r => setTimeout(r, ms))
const meta = { clips: [], shots: [], errors: [] }

function logSize () { return fs.statSync(LOG).size }
async function run (cmd, wait = 120) {
  fs.appendFileSync(CONSOLE, cmd + '\n')
  await sleep(wait)
}
function save () { fs.writeFileSync(path.join(OUT, 'capture.json'), JSON.stringify(meta, null, 1)) }

function key (k) {
  try {
    const ids = execFileSync('xdotool', ['search', '--name', 'Minecraft'], { env: process.env }).toString().trim().split('\n')
    for (const id of ids) execFileSync('xdotool', ['windowfocus', '--sync', id, 'key', '--window', id, k], { env: process.env })
  } catch (e) { meta.errors.push(`xdotool ${k}: ${e.message}`) }
}

function record (file, seconds) {
  return new Promise(resolve => {
    const p = spawn('ffmpeg', ['-y', '-loglevel', 'error', '-f', 'x11grab', '-video_size', SIZE, '-framerate', '30',
      '-i', DISPLAY, '-t', String(seconds), '-c:v', 'libx264', '-preset', 'ultrafast', '-crf', '20', '-pix_fmt', 'yuv420p',
      path.join(OUT, 'raw', file)], { stdio: ['ignore', 'inherit', 'inherit'] })
    p.on('exit', resolve)
  })
}

function shot (file) {
  try {
    execFileSync('ffmpeg', ['-y', '-loglevel', 'error', '-f', 'x11grab', '-video_size', SIZE, '-i', DISPLAY,
      '-frames:v', '1', path.join(OUT, 'shots', file)])
    meta.shots.push(file)
  } catch (e) { meta.errors.push(`shot ${file}: ${e.message}`) }
}

function join (username) {
  return new Promise((resolve, reject) => {
    const bot = mineflayer.createBot({ host: '127.0.0.1', port: 25565, username, version: '1.21.11', auth: 'offline' })
    bot.once('spawn', () => resolve(bot))
    bot.once('kicked', r => reject(new Error('kicked: ' + JSON.stringify(r))))
    bot.once('error', reject)
    setTimeout(() => reject(new Error(username + ' did not spawn')), 60000)
  })
}

async function waitLog (re, ms) {
  const end = Date.now() + ms
  while (Date.now() < end) {
    if (re.test(fs.readFileSync(LOG, 'utf8'))) return true
    await sleep(1000)
  }
  return false
}

const TARGETS = [[-2.5, 6.5], [0.5, 7.5], [3.5, 6.5], [0.5, 12.5]]
async function targets () {
  await run('kill @e[type=husk]')
  for (const [x, z] of TARGETS) {
    await run(`summon husk ${x} -60 ${z} {Silent:1b,PersistenceRequired:1b,Tags:["cap.t"],Rotation:[180f,0f],Health:200f,` +
      'attributes:[{id:"minecraft:movement_speed",base:0.0},{id:"minecraft:follow_range",base:0.0},' +
      '{id:"minecraft:attack_damage",base:0.0},{id:"minecraft:max_health",base:200.0}]}', 40)
  }
}

async function reset (pitch) {
  await run('kill @e[type=item]', 40)
  await run('tp Caster 0.5 -60 0.5 0 ' + pitch, 60)
  for (let s = 1; s <= 4; s++) await run(`scoreboard players set Caster ch.cd${s} 0`, 20)
  await run('scoreboard players set Caster ch.rage.fury 100', 20)
  await run('effect clear Caster', 20)
  await run('effect give Caster minecraft:resistance 600 4 true', 20)
  await run('effect give Caster minecraft:instant_health 1 10 true', 20)
  await run('effect give Caster minecraft:saturation 10 10 true', 20)
  await targets()
}

async function moves () {
  for (let i = 0; i < HEARTS.length; i++) {
    const h = HEARTS[i]
    if (ONLY.length && !ONLY.includes(h)) continue
    await run(`function ch:admin/give {player:"Caster",heart:"${h}"}`, 300)
    await run(`function ch:admin/mastery {player:"Caster",heart:"${h}",level:100}`, 300)
    await run(`execute as Caster run function ch:heart/set_active {i:${i + 1}}`, 300)
    await run('scoreboard players set Caster ch.swapcd 0', 50)
    await sleep(1500)
    for (let s = 1; s <= 4; s++) {
      for (const v of VARIANTS) {
        const file = `${h}_a${s}_${v.name}.mp4`
        const secs = s === 4 ? 9 : 5.5
        await reset(v.pitch)
        await sleep(700)
        const rec = record(file, secs)
        await sleep(600)
        const at = logSize()
        await run(`execute as Caster at @s run function ch:core/cast {slot:${s}}`, 50)
        await rec
        meta.clips.push({ file, heart: h, slot: s, variant: v.name, seconds: secs, preroll: 0.6, logAt: at })
        save()
        await sleep(800)
      }
    }
    await run('kill @e[type=husk]')
    await sleep(3000)
  }
}

async function firstPerson () {
  // The HUD and screen overlays only show to the caster, so Cam plays a few moves in first person.
  await run('kill @e[type=husk]')
  await run('scoreboard players set #mode cap 0')
  await run('tp Cam 0.5 -60 -2.5 0 5', 300)
  await run('gamemode survival Cam', 200)
  await run('effect give Cam minecraft:resistance 600 4 true')
  for (const h of ['rage', 'storm', 'void', 'frozen', 'celestial']) await run(`function ch:admin/give {player:"Cam",heart:"${h}"}`, 300)
  await run('scoreboard players set #mode cap 0')
  key('F1')
  for (const [h, i] of [['frozen', 5], ['rage', 1], ['celestial', 9], ['void', 4], ['storm', 6]]) {
    await run(`function ch:admin/mastery {player:"Cam",heart:"${h}",level:100}`, 300)
    await run(`execute as Cam run function ch:heart/set_active {i:${i}}`, 300)
    await run('scoreboard players set Cam ch.swapcd 0', 50)
    for (let s = 1; s <= 4; s++) await run(`scoreboard players set Cam ch.cd${s} 0`, 20)
    await run('tp Cam 0.5 -60 -2.5 0 5', 200)
    await targets()
    await sleep(2500)
    shot(`hud_${h}.png`)
    const file = `fp_${h}_ult.mp4`
    const rec = record(file, 8)
    await sleep(600)
    await run('execute as Cam at @s run function ch:core/cast {slot:4}', 50)
    await sleep(2500)
    shot(`hud_${h}_cooldown.png`)
    await rec
    meta.clips.push({ file, heart: h, slot: 4, variant: 'first-person', seconds: 8, preroll: 0.6 })
    save()
    await sleep(2000)
  }
  key('F1')
  await run('gamemode spectator Cam', 300)
}

async function orbit (file, x, y, z, secs, before) {
  await run('kill @e[type=marker,tag=cap.pivot]')
  await run(`summon marker ${x} ${y} ${z} {Tags:["cap.pivot"],Rotation:[0f,0f]}`)
  await run('scoreboard players set #mode cap 2', 200)
  if (before) await before()
  await sleep(1000)
  await record(file, secs)
  meta.clips.push({ file, variant: 'orbit', seconds: secs })
  save()
}

async function setPieces () {
  await run('kill @e[type=husk]')
  await run('tp Caster 0.5 -60 40.5 180 0', 300)
  await run('execute positioned 0 -60 30 run function ch:admin/altar/place', 1500)
  await orbit('altar.mp4', 0.5, -59, 30.5, 14)
  await run('tp Caster 0.5 -57 0.5 180 0', 300)
  await run('execute as Caster at @s run function ch:eye/on', 3000)
  await orbit('eye.mp4', 0.5, -56, 0.5, 14)
  await run('execute as Caster run function ch:eye/off', 1500)
  await run('scoreboard players set #mode cap 1')
}

async function main () {
  fs.mkdirSync(path.join(OUT, 'raw'), { recursive: true })
  fs.mkdirSync(path.join(OUT, 'shots'), { recursive: true })
  if (!await waitLog(/Cam joined the game/, 900000)) throw new Error('the client never joined')
  const caster = await join('Caster')
  caster.on('error', e => meta.errors.push('caster: ' + e.message))
  for (const c of ['op Cam', 'op Caster', 'gamemode spectator Cam', 'gamemode survival Caster', 'difficulty normal',
    'time set 6000', 'gamerule advance_time false', 'weather clear 1000000',
    'gamerule advance_weather false', 'gamerule spawn_mobs false', 'kill @e[type=!player]', 'scoreboard players set #mode cap 1']) await run(c, 200)
  await sleep(12000) // let the client finish loading chunks and the resource pack
  key('F1')
  await sleep(1000)
  shot('start.png')
  save()
  const steps = (process.env.CAPTURE_STEPS || 'moves,firstperson,setpieces').split(',')
  if (steps.includes('setpieces')) await setPieces()
  if (steps.includes('firstperson')) await firstPerson()
  if (steps.includes('moves')) await moves()
  shot('end.png')
  save()
  caster.quit()
  await sleep(1000)
}

main().then(() => process.exit(0), e => { meta.errors.push(String(e.stack || e)); save(); console.error(e); process.exit(1) })
