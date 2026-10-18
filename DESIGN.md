# Chaos Hearts SMP — Design

Target: **Minecraft Java 1.21.11**, Fabric Loader 0.19.5, Fabric API 0.141.6+1.21.11,
Loom 1.18 (official Mojang mappings), Java 21. Verified against FabricMC's own 1.21.11
example-mod branch and the Fabric API 1.21.11 sources.

## 1. Architecture

The mod is **server-side only**. Players join with a vanilla 1.21.11 client; nothing is
registered that a vanilla client would reject (no custom blocks, items or entity types).
Everything players see is built from vanilla objects:

| Need | How it is done with a vanilla client |
|---|---|
| Heart items, the casting Focus | `heart_of_the_sea` stacks with `custom_data`, `custom_model_data` strings, name, lore, glint |
| Custom textures / 3D models | Server resource pack overrides `assets/minecraft/items/heart_of_the_sea.json` with a `select` on `custom_model_data`, so players without the pack still see a sensible vanilla item |
| Projectiles, beams, black holes, boulders | Server-simulated projectiles (ray-cast every tick) drawn with particles and interpolated `item_display` / `block_display` entities |
| Bosses | Vanilla mobs with the `scale` attribute, custom attributes, equipment, boss bars and scripted attack patterns run by the mod |
| Trials | A void dimension `chaoshearts:trials` shipped in the mod's datapack; arenas are generated per run |
| Cinematics | The client camera is moved to an interpolated display entity (`ClientboundSetCameraPacket`), with titles and music |
| Custom sounds / music | `chaoshearts:*` sound events in the resource pack, sent as direct holders; every effect also layers vanilla sounds so it still sounds right without the pack |
| Menus | Chest GUIs (heart management, skill trees) |
| Screen effects | Frost vignette (`ticksFrozen`), darkness pulses, fire overlay, titles, action bar HUD |
| Ability input | Holding the Focus: right-click, sneak + right-click, swap-hands key (F), sneak + F. Also `/chaos cast <1-4>` |

Optional resource pack: the mod can host its own pack over HTTP (configurable port and public
URL) and push it to players on join, or you can host `chaoshearts-resourcepack.zip` yourself.

### Data and persistence
* All state lives in `<world>/chaoshearts/data.json`, written atomically (temp file + move),
  with the previous good copy kept as `data.json.bak`. Saved on every ownership change, every
  two minutes, and on shutdown. If `data.json` is unreadable the backup is loaded and the bad
  file is kept as `data.json.corrupt-<time>`.
* **Player record**: owned hearts (ordered by acquisition time), active heart, per-heart
  mastery XP, awakened flags, skill points and unlocked nodes, feats completed, cooldowns,
  daily XP counters, trial return point and saved game mode, Eye transformation flag.
* **Heart registry**: every physical heart has a UUID and exactly one state:
  `HELD(player)` or `DROPPED(entity uuid, position, intended collector, previous owner, expiry)`.

### Anti-duplication rules
1. A heart is never a real inventory item. Owned hearts live in the player record. The Focus item
   is only a caster bound to its owner and holds nothing; copying or stashing it gives nothing.
2. A dropped heart is an invulnerable, non-despawning item entity that only its intended collector
   can pick up. Pickup is intercepted: the entity is removed and the registry moves the heart to
   the collector in one step, then the data file is saved.
3. Every heart item entity is validated when it loads. If the registry does not say
   `DROPPED` with that exact entity UUID, the item is deleted. Any heart item that ends up in an
   inventory or container (creative middle-click, /give of a copied stack) is removed on sight.
4. Hoppers, minecart hoppers and allays cannot collect heart items.
5. If a dropped heart is destroyed (void, /kill) or its collection window expires, it returns to
   the player who lost it.

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
| 25 | Passive II, Focus gains its glint |
| 40 | Ability 3 |
| 60 | Honed: all abilities −15% cooldown, +10% damage |
| 75 | Ultimate |
| 90 | Heart aura (ambient particles), improved ability visuals |
| 100 | Awakening Trial unlocked |

## 4. Hearts

Controls with the Focus in your main hand: **A1** right-click, **A2** sneak + right-click,
**A3** swap-hands key, **ULT** sneak + swap-hands key.

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
bar "✦ HIT"), and cooldown feedback (Focus cooldown overlay, action bar HUD, a "ready" chime).

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

Awakening (per player × heart type, like mastery) grants: the awakened Focus model and aura,
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
* Every number is in `config/chaoshearts.json`.

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
