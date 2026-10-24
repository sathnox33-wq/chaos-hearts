# Chaos Hearts

A **datapack and resource pack** for **Minecraft Java 1.21.11** that turns an SMP into a fight over ten
Chaos Hearts. No mods, no plugins: it runs on a vanilla server (or Fabric/Paper, since they load datapacks
too) and players join with a vanilla client.

Each heart is a real heart on your health bar, drawn with its own icon. Every heart you hold adds one heart of
max health and a kit of four abilities. You master each heart from 0 to 100 by fighting well, beat its
Awakening Trial at an altar, then spend skill points in its tree. Hearts change hands only through PvP.

| | |
|---|---|
| Minecraft | Java 1.21.11 |
| Server | vanilla, Fabric or Paper |
| Client | vanilla, with the resource pack |

## Install

1. Download `chaoshearts-datapack.zip` and `chaoshearts-resourcepack.zip` from the release page.
2. Put `chaoshearts-datapack.zip` in `world/datapacks/` (singleplayer: the world's `datapacks` folder).
3. Host `chaoshearts-resourcepack.zip` anywhere with a direct download link (GitHub release links work), then in
   `server.properties` set:
   ```
   resource-pack=<direct link to chaoshearts-resourcepack.zip>
   resource-pack-sha1=<contents of chaoshearts-resourcepack.zip.sha1>
   require-resource-pack=true
   ```
4. **Restart the server.** The pack adds the `ch:trials` dimension, and new dimensions only load on startup;
   `/reload` is not enough the first time.
5. As an op, stand where you want the trial altar and run `/function ch:admin/altar/place`.

## Playing

New players get one random heart. Your hearts show on the second row of the health bar, each with its own icon.
The **active** heart is the one whose abilities you cast; its icon glows. The action bar shows your four
abilities with their cooldowns, and the resource meter of the active heart (Fury, Momentum, Static and so on).

### Controls

All casting is done with movement keys **while sneaking**. Tap the key (do not hold it).

| Keys | Action |
|---|---|
| Sneak + Jump | Ability 1 |
| Sneak + Sprint | Ability 2 |
| Sneak + double-tap Left (A) | Ability 3 |
| Sneak + double-tap Right (D) | Ultimate |
| Sneak + Back (S) | Shuffle to your next heart |

**Variants:** every ability has three forms. Cast it looking level, looking up, or looking down. Many abilities
also change when you cast them while moving forward. The menu describes each variant.

`/trigger hearts` opens the Chaos Hearts menu: your hearts, abilities and variants, feats, skill trees and
controls. `/trigger cast set 1`..`4` casts and `/trigger cast set 5` shuffles, for anyone who prefers binding commands.

### The hearts

| Heart | Abilities (1 · 2 · 3 · Ultimate) | Trial boss |
|---|---|---|
| Rage | Rage Leap · War Cry · Berserk Chain · Rampage | Gorrath, the Unbroken |
| Speed | Dash · Afterimage · Slipstream · Time Fracture | Vael, the Stolen Second |
| Infernal | Fireball Volley · Flame Wall · Magma Eruption · Inferno Avatar | Ignaroth, Lord of Cinders |
| Void | Void Step · Rift Orb · Displace · Singularity | The Hollow Sovereign |
| Frozen | Ice Shard · Glacial Wall · Frost Nova · Absolute Zero | Hrimvald, the Last Winter |
| Storm | Lightning Strike · Gale Burst · Chain Lightning · Tempest | Voltaris, Crown of the Tempest |
| Blood | Blood Spike · Crimson Pact · Siphon · Blood Moon | Vesperine, the Crimson Matriarch |
| Titan | Ground Slam · Stone Skin · Boulder Toss · Colossus | Golgoth, the Mountain That Walks |
| Celestial | Starfall · Sanctuary · Radiant Beam · Ascension | Astrael, the Fallen Star |
| Corruption | Plague Bolt · Rot Ground · Infest · Pandemic | Nyxara, the Blightmother |

Every heart also has two passives, an aura while active, and a stronger form once awakened.

### PvP and drops

When a player kills you, only your **most recently gained** heart drops, as a glowing heart where you died.
Only the killer can pick it up, by walking over it, for `#collect_sec` seconds. After that it returns to you.
Your other hearts stay. Logging out during combat counts as a death to your opponent. Every heart has an id
in a server-wide registry, so a heart can never exist twice.

### Mastery

Mastery goes from 0 to 100 per heart, per player. It rewards fighting, not grinding:

* XP comes from ability hits and kills on players and hostile mobs, PvP kills and boss kills.
* Hitting the same target again gives less and less XP, and a daily soft cap slows XP after `#daily_cap`.
* Feats (four per heart, such as hitting three enemies with one Rage Leap) give large one-time XP.
* Ability 2 unlocks at mastery 10, ability 3 at 40 and the ultimate at 75. At 60 your abilities hit 10% harder.

### Awakening Trials

At mastery 100, go to the **Awakening Altar** and right-click its crystal. The altar is made of barrier blocks
under its decoration, so nobody can break or blow it up. The trial is solo and takes you to an arena in the
trial dimension: an intro, three waves, then the heart's boss with three phases. You hold a **Trial Ward**
in your off hand; if it pops, you fail and return home unharmed. Win and the heart awakens: stronger
abilities and passives, plus skill points. Failing locks the trial for `#trial_retry_min` minutes.

### Skill trees

Each heart has three branches of five nodes. Points come from awakening and from mastery XP earned after level 100.
Only one capstone per heart. The first respec is free; later ones cost `#respec_lvls` XP levels.

## Admin

**`/function ch:admin`** opens the clickable admin panel and makes you a Chaos Hearts admin; after that
**`/trigger chadmin`** reopens it (its buttons never ask for confirmation). To make someone else an admin:
`/tag <name> add ch.admin`.

The panel lists every online player. Pick one to give or take any heart, switch their active heart, set mastery
(0/25/50/75/100) or awaken a heart, heal them or reset their cooldowns. It also places or removes an altar,
turns you into the Eye, prints the heart registry, returns every dropped heart, and has a Settings page for the
common `ch.cfg` values (first-join heart, unique hearts, combat-log drop, XP, damage, cooldowns, PvP damage,
collect time).

Typed commands still work (`player` can be a name, `@s` or any selector, and a wrong name or heart now says so):

| Command | What it does |
|---|---|
| `/function ch:admin/give {player:"@s",heart:"rage"}` | Give a heart |
| `/function ch:admin/take {player:"@s",heart:"rage"}` | Take a heart |
| `/function ch:admin/mastery {player:"@s",heart:"rage",level:100}` | Set mastery |
| `/function ch:admin/awaken {player:"@s",heart:"rage"}` | Awaken a heart |
| `/function ch:admin/altar/place` · `remove` | Build or remove an altar |
| `/function ch:admin/list` | Every heart on the server and who holds it |
| `/function ch:admin/help` | All of the above in chat |

### The Eye

`/function ch:eye/on` turns you into **the Eye**: a giant eye that flies, watches players and speaks.
Your inventory, health and position are saved and restored by `/function ch:eye/off`. `/function ch:eye/panel`
opens its powers: speak to everyone, whisper, gaze at a player, give a heart or take one with a beam.

## Settings

Settings are scoreboard values on `ch.cfg`. Change one with `/scoreboard players set <name> ch.cfg <value>`;
changes survive reloads. `/function ch:gen/config_reset` restores the defaults.

| Setting | Default | Meaning |
|---|---|---|
| `#starter` | 1 | 1 gives each new player a random heart, 0 gives nothing |
| `#unique` | 0 | 1 allows only one heart of each type on the server |
| `#max_hearts` | 0 | Most hearts one player can own (0 = no limit) |
| `#collect_sec` | 300 | Seconds a killer has to collect a dropped heart |
| `#combat_sec` | 15 | Seconds of combat tag after PvP damage |
| `#combat_log` | 1 | 1 makes logging out in combat drop your latest heart for your opponent |
| `#swap_sec` | 2 | Cooldown in seconds on shuffling the active heart |
| `#xp_pct` | 100 | Mastery XP multiplier in percent |
| `#daily_cap` | 2500 | Daily mastery XP before the soft cap applies |
| `#cap_pct` | 25 | Percent of XP still earned above the daily cap |
| `#xp_hit_player` | 15 | XP for an ability hit on a player |
| `#xp_hit_mob` | 5 | XP for an ability hit on a hostile mob |
| `#xp_kill_mob` | 8 | XP for an ability kill on a hostile mob |
| `#xp_pvp_kill` | 150 | XP for a PvP kill with the heart active |
| `#xp_boss` | 400 | XP for killing a Wither, Warden, Elder Guardian or Ender Dragon |
| `#pvp_pct` | 75 | Ability damage against players in percent |
| `#cc_pct` | 50 | Crowd-control duration on players in percent |
| `#dmg_pct` | 100 | Global ability damage in percent |
| `#cd_pct` | 100 | Global ability cooldowns in percent |
| `#awaken_pts` | 3 | Skill points granted on awakening |
| `#asc_per_pt` | 1000 | Ascension XP per extra skill point |
| `#max_pts` | 15 | Most skill points per heart |
| `#respec_lvls` | 20 | XP levels a respec costs after the free one |
| `#trial_retry_min` | 10 | Minutes to wait after failing a trial |
| `#trial_pct` | 100 | Trial mob health and damage in percent |
| `#trial_min` | 15 | Trial time limit in minutes |

`gamerule pvp false` turns off ability damage between players too.

## Data and safety

Everything is stored in the world (scoreboards and storage `ch:*`), so it survives restarts and backups.
Hearts are tracked by id: a drop, a pickup and a combat-log drop all move the same heart, and admin tools
are the only way to create one.

## Building from source

```
python3 tools/build_datapack.py      # generates datapack/data/ch/function/gen from tools/hearts.json and tools/kits
python3 tools/lint_datapack.py       # static checks
python3 tools/gen_assets.py          # regenerates the resource pack (needs numpy, Pillow, ffmpeg)
python3 tools/check_resourcepack.py
```

CI (`.github/workflows/build.yml`) builds both zips, boots a vanilla 1.21.11 server with them, and runs a
two-player bot scenario covering hotkeys, every ability variant, PvP drops, all ten trials, menus, the Eye and a restart.
`docs/DATAPACK_SPEC.md` is the contract for writing kits and trials.
