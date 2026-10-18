# Chaos Hearts

A server-side Fabric mod for **Minecraft Java 1.21.11** that turns an SMP into a fight over ten
Chaos Hearts. Each heart gives a kit of four abilities and two passives. Players master each heart
personally from 0 to 100, beat a solo Awakening Trial against a boss, then build a skill tree.
Hearts change hands only through PvP.

Players join with an **unmodded vanilla client**. Models, textures, sounds and trial music come from
a resource pack the server offers on join. A player who declines the pack still plays normally,
just with vanilla visuals.

| | |
|---|---|
| Minecraft | 1.21.11 (Java Edition) |
| Fabric Loader | 0.19.5 or newer |
| Fabric API | 0.141.6+1.21.11 or newer |
| Java | 21 |
| Client mods | none |

## Install

1. Install a Fabric server for 1.21.11 ([fabricmc.net/use/server](https://fabricmc.net/use/server/)).
2. Put `chaoshearts-1.0.0.jar` and Fabric API in the server's `mods/` folder.
3. Start the server once. It creates `config/chaoshearts.json`.
4. Decide how players get the resource pack (next section), then restart.

The mod adds a `chaoshearts:trials` dimension through its built-in datapack. Keep that datapack
enabled (it is on by default) or trials won't start.

### Resource pack

The jar already contains the pack. Pick one of these:

* **Built-in hosting (default).** The mod serves the pack over HTTP on `packPort` (25580). Open
  that TCP port on your firewall or host panel, then set `packPublicUrl` to the address players
  use, for example `http://play.example.com:25580/pack.zip`.
* **External hosting.** Upload `chaoshearts-resourcepack.zip` (from the release page) somewhere
  with a direct download link. Set `packExternalUrl` to that link and `packExternalSha1` to the
  contents of `chaoshearts-resourcepack.zip.sha1`. This works on hosts that won't open an extra
  port.

`packRequired: true` kicks players who decline the pack. It's off by default.

## Playing

On first join, each player gets one random heart and a **Focus**, the amulet they cast with.

### Controls (hold the Focus in your main hand)

| Input | Ability |
|---|---|
| Right-click | Ability 1 |
| Sneak + right-click | Ability 2 |
| Swap-hands key (F) | Ability 3 |
| Sneak + swap-hands key | Ultimate |

`/chaos cast <1-4>` casts the same abilities from a command, so players can bind them to keys
with a macro or command-block setup if they prefer.

The action bar shows cooldowns. A chime plays when an ability is ready. A landed hit shows
`✦ HIT` with a sound and particles on the target.

### Player commands

| Command | What it does |
|---|---|
| `/hearts` | Opens the heart menu: your hearts, active heart, mastery, abilities, trial and tree |
| `/hearts list` | Lists your hearts and mastery |
| `/hearts equip <heart>` | Makes one of your hearts the active one (30 s cooldown, not in combat) |
| `/hearts focus` | Gives you a new Focus if you lost yours |
| `/hearts info <heart>` | Shows a heart's abilities and passives |
| `/hearts feats [heart]` | Lists the one-time feats that grant mastery |
| `/hearts trial` | Starts your active heart's Awakening Trial (needs mastery 100) |
| `/hearts trial leave` | Gives up the current trial |
| `/hearts tree [heart]` | Opens an awakened heart's skill tree |

### Hearts and PvP

* A player can own several hearts. Only the **active** one gives abilities and earns mastery.
* When a player kills another player, the victim's **most recently acquired** heart drops as an
  item that only the killer can pick up. The killer has 5 minutes to collect it. After that it
  goes back to the victim. Deaths from anything other than a player drop nothing.
* Logging out during combat counts as losing the fight (`combatLogAction`).
* Hearts can't be put in hoppers, chests, item frames, ender chests or bundles. They can't be
  duplicated or destroyed. Every heart has an ID in a server registry that admins can inspect.

### Mastery

Mastery belongs to the **player**, not the heart. If someone takes your Speed Heart, they use
their own Speed mastery. If you win it back, your progress is where you left it.

Mastery comes from landing abilities on players and hostile mobs, from PvP kills and boss kills,
and from feats. It doesn't come from casting into the air. Repeatedly hitting the same target pays
less and less, and there is a daily soft cap. The full table is in [DESIGN.md](DESIGN.md#3-individual-mastery).

Abilities unlock at mastery 0, 10, 40 and 75. Mastery 60 cuts cooldowns and raises damage.
Mastery 100 unlocks the Awakening Trial.

### Awakening Trials

Each heart has its own solo trial. You're taken to a private arena that is built just for your run
in the trials dimension. The trial runs in this order:

1. An intro cinematic with the theme music.
2. Two waves of themed enemies.
3. A boss fight with four phases, telegraphed attacks and a boss bar.

You can't die in a trial. Losing ends the run and sends you back where you started, with full
health and all your items. If you fail, you can try again after 10 minutes. Winning **awakens**
the heart: you get the awakened Focus, the awakened passive and 3 skill points.

| Heart | Boss | Signature mechanic |
|---|---|---|
| Rage | Gorrath, the Unbroken | Charges that follow a red lane, a roaring shockwave, magma meteors |
| Speed | Vael, the Stolen Second | Blink strikes, afterimages that detonate, slowing clock fields |
| Infernal | Ignaroth, Lord of Cinders | Meteor rain, flame waves you jump over, homing fire charges |
| Void | The Hollow Sovereign | Pulling rifts, shadow steps, an event horizon that drags you in |
| Frozen | Hrimvald, the Last Winter | Ice spike lines, a blizzard that freezes you if you stand still, ice prisons |
| Storm | Voltaris, Crown of the Tempest | Called lightning, chain bolts that need line of sight, a tempest |
| Blood | Vesperine, the Crimson Matriarch | A draining tether, dripstone spike fans, crimson rain that heals her |
| Titan | Golgoth, the Mountain That Walks | Earthshatter lines, thrown boulders, stone skin, an avalanche |
| Celestial | Astrael, the Fallen Star | Starfall, a radiant beam, a shield you break by hitting it, a supernova you hide from behind pillars |
| Corruption | Nyxara, the Blightmother | Plague pools, web snares, broods, a rot circle that spreads from the centre |

### Skill trees

An awakened heart keeps earning XP, and every 1,000 XP gives another skill point, up to 15. Each
tree has three branches and one capstone per branch, and you can own only one capstone. The first
respec is free. After that, a respec costs 20 levels and has a 24-hour cooldown.

## Admin commands

All admin commands need permission level 2 (op).

### `/chaosadmin`

| Command | What it does |
|---|---|
| `give <player> <heart> [force]` | Creates a heart for a player. Adding the word `force` ignores unique-heart and max-heart limits |
| `take <player> <heart>` | Removes a heart from a player and destroys it. Mastery is kept |
| `transfer <from> <heart> <to>` | Moves a heart between players |
| `registry` | Lists every heart on the server and where it is |
| `destroy <id prefix>` | Destroys one heart by registry ID |
| `returnall` | Sends every dropped, uncollected heart back to its previous owner |
| `mastery <player> <heart> set <level>` | Sets mastery |
| `mastery <player> <heart> add <xp>` | Adds mastery XP |
| `awaken <player> <heart> [revoke]` | Awakens a heart for a player, or revokes it |
| `points <player> <heart> <bonus>` | Gives bonus skill points |
| `respec <player> <heart>` | Resets a skill tree for free |
| `cooldowns <players>` | Clears ability cooldowns |
| `trial start <player> <heart>` | Starts a trial and skips the normal requirements |
| `trial stop <player>` / `trial win <player>` / `trial list` | Manages running trials |
| `inspect <player>` | Shows a player's full record |
| `reset <player> confirm` | Wipes a player's hearts and progress |
| `reload` | Reloads `config/chaoshearts.json` |
| `save` | Saves data now |

### The Eye

`/eye` turns an admin into **The Eye**: a giant eye floating in a shroud of darkness. Your body
and armour are hidden. You can fly and can't be hurt. Players within 20 blocks are touched by
darkness. Everything you type in chat is spoken as the Eye and shown in a bubble above it.

| Command | What it does |
|---|---|
| `/eye` | Turns the form on or off |
| `/eye on [scale]` / `/eye off` | Turns the form on at a size (1–12, default 4), or off |
| `/eye size <scale>` | Resizes the Eye |
| `/eye say <message>` | Speaks to everyone |
| `/eye whisper <player> <message>` | Speaks only to one player |
| `/eye proclaim <message>` | Shows a title on every player's screen |
| `/eye gaze <player>` | Stares at a player, who sees darkness, glows and hears a heartbeat |
| `/eye give <player> <heart>` | Sends a heart down a beam to the player |
| `/eye take <player> [heart]` | Lifts the player up and pulls a heart into the Eye (the latest heart if none is named). Their mastery is kept |
| `/eye hearts <player>` | Lists a player's hearts |

The form ends safely if you disconnect, and anything left over is cleaned up on the next join or
server restart.

## Configuration

`config/chaoshearts.json` is created on first start. Edit it, then run `/chaosadmin reload`.

| Key | Default | Meaning |
|---|---|---|
| `starterMode` | `random` | `random` gives each new player one heart, `none` gives nothing |
| `uniqueHearts` | `false` | Allows only one heart of each type on the server |
| `maxHeartsPerPlayer` | `0` | Caps how many hearts one player can own (0 = no cap) |
| `collectWindowSeconds` | `300` | How long a killer has to pick up a dropped heart |
| `combatTagSeconds` | `15` | How long combat lasts after PvP damage |
| `combatLogAction` | `drop_heart` | What logging out in combat does: `drop_heart`, `kill` or `off` |
| `heartSwapCooldownSeconds` | `30` | Cooldown on changing the active heart |
| `masteryXpMultiplier` | `1.0` | Multiplies all mastery XP |
| `dailySoftCap` / `softCapMultiplier` | `2500` / `0.25` | XP above the daily cap is multiplied by this |
| `xpAbilityHitPlayer`, `xpAbilityHitMob`, `xpAbilityKillMob`, `xpPvpKill`, `xpBossKill` | 15, 5, 8, 150, 400 | XP sources |
| `pvpKillRepeatMinutes` | `30` | A repeat kill on the same victim within this time gives no XP |
| `pvpDamageMultiplier` | `0.75` | Ability damage against players |
| `pvpCrowdControlMultiplier` | `0.5` | Duration of crowd control on players |
| `crowdControlImmunitySeconds` | `3` | Immunity after being crowd-controlled |
| `abilityDamageMultiplier` / `cooldownMultiplier` | `1.0` / `1.0` | Global tuning |
| `maxSkillDamageBonus` | `0.40` | Cap on damage from skill trees |
| `skillPointsOnAwaken`, `ascensionXpPerPoint`, `maxSkillPoints` | 3, 1000, 15 | Skill points |
| `respecCostLevels` / `respecCooldownHours` | `20` / `24` | Respec rules |
| `trialRetryCooldownMinutes` | `10` | Wait after failing a trial |
| `trialDifficulty` | `1.0` | Scales trial mob health and damage |
| `trialTimeLimitMinutes` | `15` | Trial time limit |
| `trialBuildBlocksPerTick` | `6000` | Arena build speed. Lower it on weak hardware |
| `packServeBuiltin`, `packPort`, `packPublicUrl` | `true`, `25580`, empty | Built-in pack hosting |
| `packExternalUrl`, `packExternalSha1` | empty | External pack hosting |
| `packRequired` | `false` | Kicks players who decline the pack |
| `eyeDefaultScale`, `eyeFlySpeed`, `eyeShroudRadius` | `4.0`, `0.08`, `20` | The Eye |

## Data and safety

* All progress is stored in `<world>/chaoshearts/data.json`. The file is written atomically, a
  backup is kept, and it is saved on every heart transfer, every two minutes and on shutdown.
* If the server stops during a trial, the player is returned to their saved position and game
  mode on their next join. The arena is cleared.
* The `chaoshearts.trial` entity tag marks trial mobs. Anything that wanders into a trial arena
  is removed, and trial mobs can't hurt anyone except the challenger.

## Building from source

```
./gradlew build
```

The jar is written to `build/libs/chaoshearts-<version>.jar` and the pack to
`build/resourcepack/chaoshearts-resourcepack.zip`. GitHub Actions builds every push, boots a real
1.21.11 server with the jar and runs the admin commands against it. Pushing a `v*` tag publishes
a release.

All textures, models, sounds and music are generated by `tools/gen_assets.py` (needs numpy,
Pillow and ffmpeg with libvorbis). To regenerate them:

```
python3 tools/gen_assets.py
```

[DESIGN.md](DESIGN.md) has the full design: the numbers behind every system, the anti-duplication
rules, and the per-heart ability tables.
