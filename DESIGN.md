# Chaos Hearts SMP — Design

Target: **Minecraft Java 1.21.11**, as a datapack (format 94.1) plus a resource pack (format 75).
No mods or plugins. `docs/DATAPACK_SPEC.md` is the technical contract for kits, trials and the core API.

## 1. Architecture

Everything runs in functions under the `ch` namespace; assets live in the `chaoshearts` namespace.

| Need | How it is done in a datapack |
|---|---|
| Hearts | Not items. Ownership lives in scoreboards (`ch.cnt.<heart>`) and the registry in storage `ch:reg`. Each heart held adds +2 max health through the `ch:hearts` attribute modifier |
| Heart icons on the health bar | Action-bar text in custom fonts (`hud_r10`..`hud_r7`) whose glyphs sit exactly over the second health row; pixel-space glyphs position them with a net width of 0 |
| Ability HUD | The same action bar: four ability icons with lock, cooldown sweep and digits, plus the heart's resource meter |
| Casting | The `minecraft:player` `input` predicate (sneak + jump, sprint, double-tap left/right, back), read every tick. `/trigger cast` as a fallback |
| Effects | Emissive, tinted `item_display` models (`chaoshearts:fx/*`) that interpolate and fade, screen overlays as full-screen font glyphs in titles, camera shake, dynamic light blocks, floating damage numbers |
| Motion | A vector marker in a forceloaded chunk turns a facing into velocity; mobs get `Motion`, players get wind-charge bursts |
| Trials | The `ch:trials` dimension, 8 arena slots 1024 blocks apart, each with its own state machine (build, intro, waves, boss intro, boss, victory) |
| Altar | Barrier blocks dressed in block displays, with an interaction entity that opens a dialog |
| Menus | Dialogs (`/trigger hearts`) built from storage, with buttons that run `/trigger chmenu` |
| The Eye | Item-display models (eyeball, pupil, shroud, tendrils) that follow the admin, who flies invisibly |

### Data and persistence
* All state is in the world: scoreboards for per-player numbers (mastery XP and level, awakened flags,
  skill points and nodes, feats, cooldowns, combat tags) and storage `ch:reg` for the heart registry.
  Minecraft saves both with the world, so they survive restarts and backups.
* **Heart registry**: every heart has an id and exactly one state: `held` by a player id, or `dropped`
  with a collector, its previous holder, an expiry time and a position.

### Anti-duplication rules
1. A heart is never an inventory item, so it cannot be copied, stashed or duplicated with containers.
2. A dropped heart is a display entity linked to a registry id. Only its collector can claim it by walking
   over it; the claim moves the registry entry and the scores in one function.
3. A heart token whose registry entry does not say `dropped` with its id is removed. A dropped heart
   whose window expires, or whose token disappears, returns to the player who lost it.
4. Only admin functions create hearts; every creation takes a fresh registry id.

## 2. Hearts and ownership

**Ten hearts** ship: Rage, Speed, Infernal, Void, Frozen, Storm, Blood, Titan, Celestial and
Corruption.

* **Starting hearts**: on first join each player receives one random heart (configurable:
  `random`, `none`). Optional `uniqueHearts` mode lets each heart type exist only once on the server.
* **Multiple hearts**: a player can own several hearts but only the **active** heart grants
  abilities and passives. Swapping (`/hearts` menu) has a 30 s cooldown and is blocked while
  combat-tagged. Mastery is only earned for the active heart.
* **PvP death**: when a player dies and the kill is credited to another player (melee, projectile,
  ability, burning or bleeding caused by them, or any damage within 15 s of being hit by them), the
  victim's **most recently acquired** heart drops at the death spot for the killer. Only that one
  heart leaves; the others stay. The killer has 5 minutes (config) to collect it; afterwards it
  returns to the victim. Non-PvP deaths drop nothing.
* **Combat logging**: disconnecting while combat-tagged by a player counts as a loss to that
  player (config: `drop_heart`, `kill`, `off`).
* **Trial deaths** never drop hearts.
* If the dropped heart was active, the next most recent heart becomes active.

## 3. Individual mastery

Mastery is stored per **player × heart type**, 0–100. Holding someone else's Speed Heart uses
**your** Speed mastery; if they win it back, theirs is exactly where they left it.

Levels need `40 + 4·level` XP each (≈23,800 XP to reach 100; global multiplier in config).

| Source | XP | Anti-grind rule |
|---|---|---|
| Ability hits a player | 15 | Same target gives 50% then 25% within 60 s |
| Ability hits a hostile mob | 5 | Same rule; passive mobs, spawner mobs and mobs below 10 max health give nothing |
| Ability kills a hostile mob | 8 | Same rule |
| PvP kill with the heart active | 150 | Once per victim per 30 min |
| Kill a boss (Wither, Warden, Elder Guardian, Dragon) | 400 | |
| Feats (4 per heart, one-time skill challenges) | 300–900 | One-time |
| Daily soft cap 2,500 XP | after cap ×0.25 | Resets at midnight server time |

Casting into the air gives nothing; mastery comes from abilities that land.

### Milestones (all hearts)

| Mastery | Unlock |
|---|---|
| 0 | Ability 1, Passive I |
| 10 | Ability 2 |
| 25 | Passive II, the heart icon gains its glow |
| 40 | Ability 3 |
| 60 | Honed: all abilities −15% cooldown, +10% damage |
| 75 | Ultimate |
| 90 | Heart aura (ambient particles), improved ability visuals |
| 100 | Awakening Trial unlocked |

## 4. Hearts

Controls, all while sneaking: **A1** jump, **A2** sprint, **A3** double-tap left, **ULT** double-tap right,
shuffle with back. Each ability has three variants: cast looking level, up or down.

| Heart | Passive I / II | A1 | A2 | A3 | Ultimate | Awakened |
|---|---|---|---|---|---|---|
| **Rage** | Fury meter from dealing/taking damage; +10% melee at 50 Fury / at 100 Fury gain Strength I | Rage Leap (leap + slam AoE) | War Cry (weaken foes, empower self, spends Fury) | Berserk Chain (next 3 hits shockwave) | Rampage (speed, strength, lifesteal, kills extend it) | Wrath Incarnate: Fury cap 150, black-red flame aura |
| **Speed** | Permanent Speed I / Momentum: sprinting 3 s empowers next hit | Dash (blink 8 blocks, damages what you pass) | Afterimage (decoy mannequin + invisibility) | Slipstream (Speed III, trail that slows enemies) | Time Fracture (enemies near you slowed to a crawl, clock VFX) | Lightspeed: dash has 2 charges, electric trails |
| **Infernal** | Fire Resistance / hits ignite | Fireball Volley (3 fireballs) | Flame Wall (burning barrier) | Magma Eruption (telegraphed geyser) | Inferno Avatar (burning aura, auto fireballs) | Hellfire: blue soul-fire visuals, fire ignores Fire Resistance partially |
| **Void** | 15% chance to phase through projectiles / hits apply Darkness | Void Step (teleport) | Rift Orb (pulling orb) | Displace (swap places with target) | Singularity (black hole, implosion) | Event Horizon: Void Step leaves a rift you can return to |
| **Frozen** | Freeze immunity + frost walking / Frostbite stacks freeze foes | Ice Shard | Glacial Wall (temporary ice) | Frost Nova | Absolute Zero (blizzard + ice spikes) | Permafrost: frozen enemies shatter for bonus damage |
| **Storm** | Speed in rain, lightning immunity / every 4th hit chains a spark | Lightning Strike | Gale Burst (knockback + updraft) | Chain Lightning (5 bounces) | Tempest (become the storm, lightning rain) | Thunder God: strikes leave charged ground |
| **Blood** | Lifesteal 10% / crits cause Bleed | Blood Spike | Crimson Pact (pay HP for Strength II) | Siphon (drain tether) | Blood Moon (40% lifesteal, bleeding aura) | Sanguine Lord: overheal becomes absorption |
| **Titan** | +2 hearts, 30% knockback resistance / −10% damage below half HP | Ground Slam (line shockwave) | Stone Skin (Resistance II) | Boulder Toss | Colossus (grow to 1.6× size, shockwave hits) | Mountain: Colossus size 2×, slams leave fissures |
| **Celestial** | Night Vision, sunlight regeneration / +25% vs undead, regen pulses for teammates | Starfall | Sanctuary (healing zone) | Radiant Beam | Ascension (rise, 60% damage reduction, star rain) | Supernova: Ascension ends in a radiant blast |
| **Corruption** | Poison/Wither immunity / hits apply Blight | Plague Bolt (poison cloud) | Rot Ground (withering zone) | Infest (delayed burst that spreads) | Pandemic (infect everyone near, raise corrupted minions) | Blight Lord: infections jump between targets |

Every ability has: an activation sequence (wind-up particles and sound), its main effect,
impact VFX and sound, a hit indicator for the caster (sound + particles on the target + action
bar "✦ HIT"), and cooldown feedback (cooldown sweep and digits on the action-bar HUD, a "ready" chime).

### Feats (examples)
Rage: hit 3 enemies with one Rage Leap; win a fight below 3 hearts while Rampaging.
Speed: kill within 3 s of a Dash; travel 2,000 blocks while Slipstream is active.
Each heart has four feats, listed in-game under `/hearts feats`.

## 5. Awakening trials

At 100 mastery, `/hearts trial` (or the menu) starts the heart's trial. The player must own a
heart of that type and be out of combat.

* **Instancing**: each run builds its own arena in the `chaoshearts:trials` void dimension, 2,048
  blocks from any other run. Only the challenger is there. Arenas are built gradually during the
  intro cinematic so the server does not stall, and erased after the run.
* **Safety**: the player is in Adventure mode inside (no building or digging), their position and
  game mode are saved, and they are restored on victory, failure, disconnect or server restart.
  Dying inside a trial does not kill you: it fails the trial and returns you with full health and
  your inventory intact. Trial mobs cannot leave the arena and are removed at the end.
* **Structure**: an orbiting cinematic flythrough with title cards and the heart's theme music →
  Wave 1 → Wave 2 (themed adds, raid horn and wave titles) → boss entrance → boss fight in four
  phases (phase 3 at 50% health brings an enrage wave, phase 4 at 20%) → victory sequence with
  fireworks → awakening. Every boss attack is telegraphed on the ground first.
* **Failure**: death, leaving the arena bounds, or the time limit (15 min). You can retry after 10
  minutes.
* Replays after awakening are allowed and record your best time; they give no extra rewards.
* **Exploit protection**: trial mobs only take damage from the challenger, give no XP or drops,
  can't be leashed out of the arena, and are discarded at the end. Items other than the
  challenger's own throws are deleted in the trials dimension. Intruders (anyone without a
  session) are removed every second. Mastery is never granted for hitting trial mobs.

| Heart | Arena | Boss | Phase 1–2 | Phase 3–4 |
|---|---|---|---|---|
| Rage | The Crucible of Fury | Gorrath, the Unbroken (ravager) | Charges down a telegraphed lane, roar shockwave | Bloodrage (faster, harder), magma meteors |
| Speed | The Racing Hour | Vael, the Stolen Second (vindicator) | Blink strikes, afterimage lines that detonate | Slowing clock fields, tick-tock blasts |
| Infernal | The Cinder Throne | Ignaroth, Lord of Cinders (giant blaze) | Meteor rain, flame wave you must jump | Hellgate fire zones, homing fire charges |
| Void | The Hollow Beneath | The Hollow Sovereign (enderman) | Pulling rift orb, shadow step with Darkness | Void cracks, event horizon pulling to the centre |
| Frozen | The Last Winter | Hrimvald, the Last Winter (stray) | Ice spike lines, blizzard that freezes still players | Ice prison, permanent blizzard |
| Storm | The Eye of the Storm | Voltaris, Crown of the Tempest (trident skeleton) | Called lightning, chain bolt (needs line of sight) | Static zones, tempest swirl with random bolts |
| Blood | The Crimson Communion | Vesperine, the Crimson Matriarch (evoker) | Draining tether that heals her, dripstone spike fans with Bleed | Crimson rain zones that heal her |
| Titan | The Mountain That Walks | Golgoth, the Mountain That Walks (2.2× iron golem) | Earthshatter lines, boulder throws | Stone skin (×0.35 damage taken), avalanche |
| Celestial | The Fallen Firmament | Astrael, the Fallen Star (3.2× vex) | Starfall, radiant beam | Sanctuary shield broken by 7 hits, supernova you hide from behind pillars |
| Corruption | The Rotting Garden | Nyxara, the Blightmother (giant spider) | Plague spit pools, web snare and lunge | Broods and a rot trail, a rot circle spreading from the centre |

## 6. Awakening and skill trees

Awakening (per player × heart type, like mastery) grants: the awakened heart icon and aura,
the awakened passive, **3 skill points**, and opens the heart's skill tree.

* **Skill points after awakening**: mastery XP keeps accumulating as *Ascension XP*; every 1,000
  gives a point, up to 15 points total per heart.
* **Tree shape**: three branches × four nodes (costs 1/2/2/3) plus a capstone (cost 4) at the end
  of each branch. A branch costs 12, so 15 points buy one full branch and part of another. Only
  **one capstone** can be owned, so each build commits to an identity.
* **Respec**: from the tree menu. First respec is free, then costs 20 XP levels, 24 h cooldown.
* Example (Rage): *Butcher* (damage, crit shockwaves) / *Juggernaut* (damage reduction, Fury
  from taking hits) / *Warlord* (War Cry buffs allies, Fury spending).

## 7. PvP balance

* Ability damage against players ×0.75; crowd control on players lasts half as long and grants
  3 s of immunity to the same control afterwards.
* Abilities respect scoreboard teams and the server's PvP setting.
* Total ability damage bonus from the skill tree is capped at +40%.
* Ultimates have 120–150 s cooldowns. Ascension-style defensive ultimates reduce damage rather
  than grant invulnerability.
* Every number is a `ch.cfg` score (see the README's Settings table).

## 8. Admin tools

`/chaosadmin` (permission level 2): give/take hearts, list the heart registry, set/add mastery,
awaken/unawaken, add skill points, respec, reset cooldowns, start/stop/win trials, reload
config, reset a player, return dropped hearts.

`/eye` (permission level 2) transforms the admin into **The Eye**: a giant eye wrapped in a shroud
of darkness (resource-pack model with a vanilla fallback), the admin's body hidden, free flight,
invulnerable. While transformed:
* chat becomes the Eye's voice (styled message, deep sound, floating text above the Eye);
  `/eye say`, `/eye whisper <player> <message>`, `/eye proclaim <message>`;
* `/eye gaze <player>`: the Eye stares at a player, who feels darkness and a heartbeat;
* `/eye give <player> <heart>` and `/eye take <player> [heart]` with beam and tearing
  animations, going through the same ownership rules as everything else;
* `/eye size`, `/eye off`. The transformation is undone safely on disconnect or restart.
