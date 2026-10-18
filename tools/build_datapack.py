#!/usr/bin/env python3
"""
Generates the repetitive parts of the Chaos Hearts datapack from tools/hearts.json:
scoreboard setup, per-heart dispatch, Focus item modifiers, menu text and constants.

Hand-written functions live next to the generated ones under datapack/data/ch/function.
Generated files are all under a path containing "gen" (or are item modifiers) and are rewritten
on every run, so edit this script rather than the output.

    python3 tools/build_datapack.py
"""
import json
import os
import shutil

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DP = os.path.join(ROOT, "datapack")
FN = os.path.join(DP, "data", "ch", "function")
HEARTS = json.load(open(os.path.join(ROOT, "tools", "hearts.json"), encoding="utf-8"))

# index, id, display name, colour, secondary colour
TYPES = [
    (1, "rage", "Rage", "#E0262B", "#5A0A0A"),
    (2, "speed", "Speed", "#F5E142", "#29D3F2"),
    (3, "infernal", "Infernal", "#FF7A1A", "#8C1C00"),
    (4, "void", "Void", "#8A3CFF", "#14002B"),
    (5, "frozen", "Frozen", "#9BE7FF", "#2F6FA8"),
    (6, "storm", "Storm", "#4FA8FF", "#E8F6FF"),
    (7, "blood", "Blood", "#9E0B1F", "#2B0006"),
    (8, "titan", "Titan", "#C9A45C", "#5B5348"),
    (9, "celestial", "Celestial", "#FFF2B0", "#FFC94A"),
    (10, "corruption", "Corruption", "#7BD13A", "#3D1A52"),
]
LORE = {
    "rage": "Fury given form. It grows stronger the longer the fight lasts.",
    "speed": "A heart that never stops racing. Time bends around it.",
    "infernal": "Forged in the deepest lava. It burns everything it touches.",
    "void": "A hole in the world, beating. Space folds at its will.",
    "frozen": "So cold it hurts to hold. It stills blood and breath.",
    "storm": "Thunder trapped in a chamber of glass, begging to be let out.",
    "blood": "It hungers. Every wound you deal feeds it, and you.",
    "titan": "The heart of a mountain. Unmoving, unbreakable, enormous.",
    "celestial": "A fallen star that still remembers the sky.",
    "corruption": "Rot that thinks. It spreads from host to host.",
}
UNLOCK = [0, 10, 40, 75]
PER_HEART = ["own", "cnt", "xp", "lvl", "awk", "asc", "pts", "tree", "feat", "best", "ret"]
CORE = [
    "ch.pid", "ch.active", "ch.lvl", "ch.awake", "ch.b1", "ch.b2", "ch.b3",
    "ch.cd1", "ch.cd2", "ch.cd3", "ch.cd4", "ch.cdm1", "ch.cdm2", "ch.cdm3", "ch.cdm4",
    "ch.ctag", "ch.opp", "ch.swapcd", "ch.xpday", "ch.day", "ch.tgt", "ch.tgtn", "ch.tgtt",
    "ch.seen", "ch.hud", "ch.ccimm", "ch.trial", "ch.retry", "ch.eye", "ch.msg", "ch.respec",
    "ch.owner", "ch.life", "ch.t", "ch.eid", "ch.hid", "ch.slot", "ch.state", "ch.phase",
    "ch.v1", "ch.v2", "ch.v3", "ch.v4", "ch.v5", "ch.v6", "ch.tmp", "ch.g", "ch.cfg",
]
CONFIG = {
    # name: (default, meaning)
    "#starter": (1, "1 gives each new player a random heart, 0 gives nothing"),
    "#unique": (0, "1 allows only one heart of each type on the server"),
    "#max_hearts": (0, "Most hearts one player can own (0 = no limit)"),
    "#collect_sec": (300, "Seconds a killer has to collect a dropped heart"),
    "#combat_sec": (15, "Seconds of combat tag after PvP damage"),
    "#combat_log": (1, "1 makes logging out in combat drop your latest heart for your opponent"),
    "#swap_sec": (30, "Cooldown in seconds on changing the active heart"),
    "#xp_pct": (100, "Mastery XP multiplier in percent"),
    "#daily_cap": (2500, "Daily mastery XP before the soft cap applies"),
    "#cap_pct": (25, "Percent of XP still earned above the daily cap"),
    "#xp_hit_player": (15, "XP for an ability hit on a player"),
    "#xp_hit_mob": (5, "XP for an ability hit on a hostile mob"),
    "#xp_kill_mob": (8, "XP for an ability kill on a hostile mob"),
    "#xp_pvp_kill": (150, "XP for a PvP kill with the heart active"),
    "#xp_boss": (400, "XP for killing a Wither, Warden, Elder Guardian or Ender Dragon"),
    "#pvp_pct": (75, "Ability damage against players in percent"),
    "#cc_pct": (50, "Crowd-control duration on players in percent"),
    "#dmg_pct": (100, "Global ability damage in percent"),
    "#cd_pct": (100, "Global ability cooldowns in percent"),
    "#awaken_pts": (3, "Skill points granted on awakening"),
    "#asc_per_pt": (1000, "Ascension XP per extra skill point"),
    "#max_pts": (15, "Most skill points per heart"),
    "#respec_lvls": (20, "XP levels a respec costs after the free one"),
    "#trial_retry_min": (10, "Minutes to wait after failing a trial"),
    "#trial_pct": (100, "Trial mob health and damage in percent"),
    "#trial_min": (15, "Trial time limit in minutes"),
}


def write(rel, text):
    path = os.path.join(DP, rel)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(text.rstrip("\n") + "\n")


def fn(rel, lines):
    write(os.path.join("data", "ch", "function", rel + ".mcfunction"), "\n".join(lines))


def snbt(s):
    return json.dumps(s, ensure_ascii=False)


def gen():
    gen_dir = os.path.join(FN, "gen")
    if os.path.isdir(gen_dir):
        shutil.rmtree(gen_dir)

    # ---- objectives
    lines = ["# Generated by tools/build_datapack.py"]
    for o in CORE:
        lines.append(f"scoreboard objectives add {o} dummy")
    for _, h, *_ in TYPES:
        for p in PER_HEART:
            lines.append(f"scoreboard objectives add ch.{p}.{h} dummy")
    lines += [
        "scoreboard objectives add ch.use minecraft.used:minecraft.carrot_on_a_stick",
        "scoreboard objectives add ch.deaths deathCount",
        "scoreboard objectives add ch.leave minecraft.custom:minecraft.leave_game",
        "scoreboard objectives add hearts trigger",
        "scoreboard objectives add cast trigger",
        "scoreboard objectives add chmenu trigger",
    ]
    fn("gen/objectives", lines)

    # ---- config defaults (only set when missing, so admins' changes survive reloads)
    lines = ["# Generated: default settings. Change them with /scoreboard players set <name> ch.cfg <value>."]
    for k, (v, why) in CONFIG.items():
        lines.append(f"# {k}: {why}")
        lines.append(f"execute unless score {k} ch.cfg = {k} ch.cfg run scoreboard players set {k} ch.cfg {v}")
    fn("gen/config_defaults", lines)
    lines = ["# Generated: resets every setting to its default."]
    for k, (v, _) in CONFIG.items():
        lines.append(f"scoreboard players set {k} ch.cfg {v}")
    fn("gen/config_reset", lines)

    # ---- constants in storage
    const = {
        "names": ["none"] + [t[1] for t in TYPES],
        "titles": ["None"] + [t[2] for t in TYPES],
        "colors": ["#888888"] + [t[3] for t in TYPES],
    }
    fn("gen/constants", [
        "# Generated: per-heart constants used by menus and macros.",
        f"data modify storage ch:const names set value {snbt(const['names'])}",
        f"data modify storage ch:const titles set value {snbt(const['titles'])}",
        f"data modify storage ch:const colors set value {snbt(const['colors'])}",
        "scoreboard players set #2 ch.g 2", "scoreboard players set #4 ch.g 4",
        "scoreboard players set #10 ch.g 10", "scoreboard players set #20 ch.g 20",
        "scoreboard players set #38 ch.g 38", "scoreboard players set #60 ch.g 60",
        "scoreboard players set #100 ch.g 100", "scoreboard players set #1000 ch.g 1000",
        "scoreboard players set #1200 ch.g 1200", "scoreboard players set #24000 ch.g 24000",
        "scoreboard players set #-1 ch.g -1",
    ])

    # ---- per heart dispatch tables
    kit_tick = ["# Generated: runs each heart's per-player and world tick."]
    for i, h, *_ in TYPES:
        kit_tick.append(f"execute as @a[scores={{ch.active={i}}}] at @s run function ch:kit/{h}/tick")
    for i, h, *_ in TYPES:
        kit_tick.append(f"function ch:kit/{h}/world_tick")
    fn("gen/kit_tick", kit_tick)

    for ev in ("on_attack", "on_hurt", "on_kill", "equip", "unequip", "hud"):
        lines = [f"# Generated: calls {ev} on the player's active heart."]
        for i, h, *_ in TYPES:
            lines.append(f"execute if score @s ch.active matches {i} run function ch:kit/{h}/{ev}")
        fn(f"gen/{ev}", lines)

    lines = ["# Generated: casts slot #slot ch.tmp of the active heart. Returns the kit's result."]
    for i, h, *_ in TYPES:
        for s in range(1, 5):
            lines.append(f"execute if score @s ch.active matches {i} if score #slot ch.tmp matches {s} run return run function ch:kit/{h}/a{s}")
    lines.append("return fail")
    fn("gen/cast", lines)

    # active-heart derived scores (level, awakened, branches)
    lines = ["# Generated: copies the active heart's level, awakening and tree into ch.lvl, ch.awake and ch.b1-3."]
    lines += ["scoreboard players set @s ch.lvl 0", "scoreboard players set @s ch.awake 0",
              "scoreboard players set #tree ch.tmp 0"]
    for i, h, *_ in TYPES:
        lines.append(f"execute if score @s ch.active matches {i} run scoreboard players operation @s ch.lvl = @s ch.lvl.{h}")
        lines.append(f"execute if score @s ch.active matches {i} run scoreboard players operation @s ch.awake = @s ch.awk.{h}")
        lines.append(f"execute if score @s ch.active matches {i} run scoreboard players operation #tree ch.tmp = @s ch.tree.{h}")
    lines += [
        "scoreboard players operation @s ch.b1 = #tree ch.tmp",
        "scoreboard players operation @s ch.b1 %= #10 ch.g",
        "scoreboard players operation #tree ch.tmp /= #10 ch.g",
        "scoreboard players operation @s ch.b2 = #tree ch.tmp",
        "scoreboard players operation @s ch.b2 %= #10 ch.g",
        "scoreboard players operation #tree ch.tmp /= #10 ch.g",
        "scoreboard players operation @s ch.b3 = #tree ch.tmp",
        "scoreboard players operation @s ch.b3 %= #10 ch.g",
    ]
    fn("gen/sync_active", lines)

    # latest heart: #best ch.tmp = highest acquisition number, #bestidx ch.tmp = its index
    lines = ["# Generated: finds the most recently acquired heart (#bestidx ch.tmp, 0 if none).",
             "scoreboard players set #best ch.tmp 0", "scoreboard players set #bestidx ch.tmp 0"]
    for i, h, *_ in TYPES:
        lines.append(f"execute if score @s ch.own.{h} > #best ch.tmp run scoreboard players set #bestidx ch.tmp {i}")
        lines.append(f"execute if score @s ch.own.{h} > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.{h}")
    fn("gen/latest", lines)

    # mastery XP goes to the active heart
    lines = ["# Generated: adds #x ch.tmp mastery XP to the active heart."]
    for i, h, *_ in TYPES:
        lines.append(f"execute if score @s ch.active matches {i} run return run function ch:mastery/add {{h:\"{h}\",i:{i}}}")
    fn("gen/award", lines)

    # count owned
    lines = ["# Generated: #owned ch.tmp = number of hearts the player holds.", "scoreboard players set #owned ch.tmp 0"]
    for i, h, *_ in TYPES:
        lines.append(f"scoreboard players operation #owned ch.tmp += @s ch.cnt.{h}")
    fn("gen/count", lines)

    # name -> index and index -> name helpers for macros: ch:gen/index {h:"rage"} returns index
    for i, h, *_ in TYPES:
        fn(f"gen/index/{h}", [f"return {i}"])

    # per-heart level recompute after XP changes: level L needs 2L^2+38L total XP
    for i, h, *_ in TYPES:
        fn(f"gen/level/{h}", [
            f"# Generated: recomputes ch.lvl.{h} from ch.xp.{h} and reports milestones.",
            f"scoreboard players operation #old ch.tmp = @s ch.lvl.{h}",
            f"scoreboard players operation #xp ch.tmp = @s ch.xp.{h}",
            "function ch:mastery/level_from_xp",
            f"scoreboard players operation @s ch.lvl.{h} = #lvl ch.tmp",
            f"execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {{h:\"{h}\",i:{i}}}",
        ])

    # registry of heart titles for tellraw (macro-free colour lookup)
    lines = ["# Generated: sets storage ch:tmp title/color/name for heart index #i ch.tmp."]
    for i, h, name, col, _ in TYPES:
        r, g, b = (int(col[k:k + 2], 16) for k in (1, 3, 5))
        rgbf = f"[{r / 255:.3f},{g / 255:.3f},{b / 255:.3f}]"
        lines.append(
            f"execute if score #i ch.tmp matches {i} run data modify storage ch:tmp h set value "
            f"{{name:\"{h}\",title:\"{name}\",color:\"{col}\",i:{i},rgb:{int(col[1:], 16)},rgbf:\"{rgbf}\"}}")
    lines.append('execute if score #i ch.tmp matches 0 run data modify storage ch:tmp h set value {name:"none",title:"None",color:"#888888",i:0,rgb:8947848,rgbf:"[0.5,0.5,0.5]"}')
    fn("gen/describe", lines)

    # ---- Focus item modifiers
    for i, h, name, col, _ in TYPES:
        meta = HEARTS[h]
        for awakened in (False, True):
            lore = [{"text": LORE[h], "color": "dark_gray", "italic": True}, {"text": ""}]
            for s, a in enumerate(meta["abilities"]):
                key = ["Right-click", "Sneak + Right-click", "Swap hands (F)", "Sneak + Swap hands"][s]
                lore.append({"text": "", "italic": False, "extra": [
                    {"text": f"{a['name']}", "color": col},
                    {"text": f"  {key}", "color": "gray"},
                    {"text": f"  (mastery {UNLOCK[s]})" if UNLOCK[s] else "", "color": "dark_gray"}]})
            lore.append({"text": ""})
            lore.append({"text": "Your mastery and skills belong to you, not the heart.", "color": "dark_gray", "italic": False})
            comps = {
                "minecraft:item_model": f"chaoshearts:focus_{h}" + ("_awakened" if awakened else ""),
                "minecraft:custom_name": {"text": ("Awakened " if awakened else "") + f"{name} Focus", "color": col,
                                          "italic": False, "bold": awakened},
                "minecraft:lore": lore,
                "minecraft:custom_data": {"ch": {"focus": 1, "h": i}},
                "minecraft:rarity": "epic" if awakened else "rare",
                "minecraft:unbreakable": {},
                "minecraft:enchantment_glint_override": awakened,
                "minecraft:tooltip_display": {"hidden_components": ["minecraft:unbreakable"]},
            }
            suffix = "_awakened" if awakened else ""
            write(f"data/ch/item_modifier/focus/{h}{suffix}.json",
                  json.dumps([{"function": "minecraft:set_components", "components": comps}], indent=1, ensure_ascii=False))
    write("data/ch/item_modifier/focus/glint.json", json.dumps(
        [{"function": "minecraft:set_components", "components": {"minecraft:enchantment_glint_override": True}}], indent=1))
    write("data/ch/item_modifier/focus/blank.json", json.dumps(
        [{"function": "minecraft:set_components", "components": {
            "minecraft:item_model": "chaoshearts:focus_none",
            "minecraft:custom_name": {"text": "Empty Focus", "color": "gray", "italic": False},
            "minecraft:lore": [{"text": "You have no heart. Win one in PvP.", "color": "dark_gray", "italic": False}],
            "minecraft:custom_data": {"ch": {"focus": 1, "h": 0}}}}], indent=1))

    # applies the right Focus look to whichever slot holds the Focus
    slots = ["weapon.mainhand", "weapon.offhand"] + [f"hotbar.{n}" for n in range(9)] + [f"inventory.{n}" for n in range(27)]
    lines = ["# Generated: restyles every Focus the player carries. Macro: $(mod) is the item modifier.",
             "scoreboard players set #found ch.tmp 0"]
    for s in slots:
        lines.append(f"$execute if items entity @s {s} carrot_on_a_stick[custom_data~{{ch:{{focus:1}}}}] "
                     f"store success score #found ch.tmp run item modify entity @s {s} $(mod)")
    fn("gen/focus_restyle", lines)

    # ---- menu text for each heart (abilities, passives, branches) kept in storage for the dialogs
    menu = {}
    for i, h, name, col, _ in TYPES:
        m = HEARTS[h]
        menu[h] = {
            "title": name, "color": col, "lore": LORE[h], "i": i,
            "a": [{"name": a["name"], "desc": a["desc"], "cd": a["cd"], "unlock": UNLOCK[n]} for n, a in enumerate(m["abilities"])],
            "p1": m["p1"], "p1d": m["p1d"], "p2": m["p2"], "p2d": m["p2d"], "aw": m["aw"], "awd": m["awd"],
            "feats": [{"name": f["name"], "desc": f["desc"], "xp": f["xp"]} for f in m["feats"]],
            "br": [{"name": b["name"], "desc": b["desc"], "n": [{"name": n["name"], "desc": n["desc"]} for n in b["nodes"]]}
                   for b in m["branches"]],
        }
    fn("gen/menu_data", ["# Generated: ability, passive, feat and skill text for the menus.",
                         f"data modify storage ch:const menu set value {snbt(menu)}"])

    # ---- per heart objectives that kits use (rage fury etc) are created by each kit's load function
    lines = ["# Generated: runs each heart's load function."]
    for i, h, *_ in TYPES:
        lines.append(f"function ch:kit/{h}/load")
    fn("gen/kit_load", lines)

    # admin helper: full heart list for argument checks
    print("datapack generated in", DP)


if __name__ == "__main__":
    gen()
