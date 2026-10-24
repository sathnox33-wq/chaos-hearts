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
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import vfx_shapes  # noqa: E402
import vfx_signatures  # noqa: E402

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
    "ch.stun", "ch.shake", "ch.shakes", "ch.meter", "ch.tap", "ch.kj", "ch.ks", "ch.ka", "ch.kd", "ch.kb", "ch.dta", "ch.dtd", "ch.v1", "ch.v2", "ch.v3", "ch.v4", "ch.v5", "ch.v6", "ch.tmp", "ch.g", "ch.cfg",
    "ch.mbx", "ch.mbl", "ch.mba", "ch.mbg", "ch.mbf", "ch.adt",
]
CONFIG = {
    # name: (default, meaning)
    "#starter": (1, "1 gives each new player a random heart, 0 gives nothing"),
    "#unique": (0, "1 allows only one heart of each type on the server"),
    "#max_hearts": (0, "Most hearts one player can own (0 = no limit)"),
    "#collect_sec": (300, "Seconds a killer has to collect a dropped heart"),
    "#combat_sec": (15, "Seconds of combat tag after PvP damage"),
    "#combat_log": (1, "1 makes logging out in combat drop your latest heart for your opponent"),
    "#swap_sec": (2, "Cooldown in seconds on shuffling the active heart"),
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

    # ---- VFX library: particle shapes and the colour -> theme table
    n_shapes, n_pts = vfx_shapes.write_shapes(FN)
    fn("gen/vfx_themes", ["# Generated: themed particles for every colour the kits use (see tools/vfx_shapes.py).",
                          f"data modify storage ch:vfx th set value {snbt(vfx_shapes.theme_table(FN, TYPES, vfx_signatures.extra_colors()))}"])

    # ---- objectives
    lines = ["# Generated by tools/build_datapack.py"]
    for o in CORE:
        lines.append(f"scoreboard objectives add {o} dummy")
    for _, h, *_ in TYPES:
        for p in PER_HEART:
            lines.append(f"scoreboard objectives add ch.{p}.{h} dummy")
    lines += [
        "scoreboard objectives add ch.health health",
        "scoreboard objectives add ch.deaths deathCount",
        "scoreboard objectives add ch.leave minecraft.custom:minecraft.leave_game",
        "scoreboard objectives add hearts trigger",
        "scoreboard objectives add cast trigger",
        "scoreboard objectives add chmenu trigger",
        "scoreboard objectives add chadmin trigger",
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
        "scoreboard players set #2 ch.g 2", "scoreboard players set #4 ch.g 4", "scoreboard players set #5 ch.g 5", "scoreboard players set #8 ch.g 8",
        "scoreboard players set #10 ch.g 10", "scoreboard players set #20 ch.g 20",
        "scoreboard players set #38 ch.g 38", "scoreboard players set #60 ch.g 60",
        "scoreboard players set #100 ch.g 100", "scoreboard players set #85 ch.g 85", "scoreboard players set #110 ch.g 110", "scoreboard players set #1000 ch.g 1000",
        "scoreboard players set #1200 ch.g 1200", "scoreboard players set #24000 ch.g 24000",
        "scoreboard players set #-1 ch.g -1",
    ])

    # ---- overlay glyphs for ch:api/fx/screen
    glyphs = json.load(open(os.path.join(ROOT, "tools", "glyphs.json"), encoding="utf-8"))
    ov = {k: chr(int(v, 16)) for k, v in glyphs["overlays"]["glyphs"].items()}
    fn("gen/overlays", ["# Generated: overlay glyph characters for ch:api/fx/screen.",
                        f"data modify storage ch:const overlay set value {snbt(ov)}"])

    # ---- per heart dispatch tables
    kit_tick = ["# Generated: runs each heart's per-player and world tick."]
    for i, h, *_ in TYPES:
        kit_tick.append(f"execute as @a[scores={{ch.active={i}}}] at @s run function ch:kit/{h}/tick")
    for i, h, *_ in TYPES:
        kit_tick.append(f"function ch:kit/{h}/world_tick")
    fn("gen/kit_tick", kit_tick)

    for ev in ("on_attack", "on_hurt", "on_kill", "equip", "unequip"):
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

    lines = ["# Generated: after a successful cast, applies the ability's listed cooldown unless the kit set its own."]
    for i, h, *_ in TYPES:
        for s_, a in enumerate(HEARTS[h]["abilities"], start=1):
            lines.append(f"execute if score @s ch.active matches {i} if score #slot ch.tmp matches {s_} if score @s ch.cd{s_} matches 0 run return run function ch:api/cooldown {{slot:{s_},t:{a['cd'] * 20}}}")
    fn("gen/cd_default", lines)

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

    # next held heart for the shuffle hotkey: smallest index above the active one, else the smallest held
    lines = ["# Generated: #next ch.tmp = the heart the shuffle hotkey moves to.",
             "scoreboard players operation #next ch.tmp = @s ch.active", "scoreboard players set #wrap ch.tmp 0"]
    for i, h, *_ in reversed(TYPES):
        lines.append(f"execute if score @s ch.cnt.{h} matches 1.. if score @s ch.active matches ..{i - 1} run scoreboard players set #above ch.tmp {i}")
    lines.insert(3, "scoreboard players set #above ch.tmp 0")
    for i, h, *_ in reversed(TYPES):
        lines.append(f"execute if score @s ch.cnt.{h} matches 1.. run scoreboard players set #wrap ch.tmp {i}")
    lines += ["execute if score #above ch.tmp matches 1.. run return run scoreboard players operation #next ch.tmp = #above ch.tmp",
              "execute if score #wrap ch.tmp matches 1.. run scoreboard players operation #next ch.tmp = #wrap ch.tmp"]
    fn("gen/next_held", lines)

    # ---- HUD glyph tables (see tools/glyphs.json)
    gl = glyphs
    sp = {int(v): chr(int(k, 16)) for k, v in gl["space"]["advances"].items()}

    def space(n):
        out = ""
        for step in (128, 64, 32, 16, 8, 4, 2, 1):
            while abs(n) >= step:
                out += sp[step if n > 0 else -step]
                n += -step if n > 0 else step
        return out
    hb = int(gl["hearts"]["base"], 16)
    ab = int(gl["abilities"]["base"], 16)
    ex = gl["ability_extra"]["glyphs"]
    hud = {
        "sp": [space(n) for n in range(-200, 201)],
        "hg": [chr(hb + k) for k in range(80)],
        "ab": [chr(ab + k) for k in range(40)],
        "lock": chr(int(ex["lock"], 16)), "ready": chr(int(ex["ready_frame"], 16)), "frame": chr(int(ex["frame"], 16)),
        "cd": [chr(int(ex[f"cd_{k}"], 16)) for k in range(9)],
        "dg": [chr(int(gl["digits"]["base"], 16) + k) for k in range(10)],
        "mt": [chr(int(gl["meter"]["base"], 16) + k) for k in range(21)],
        "key": [""] + [chr(int(gl["keys"]["base"], 16) + k) for k in range(4)],
    }
    mb, k = {}, int(gl["mastery"]["base"], 16)
    for name, n in gl["mastery"]["parts"]:
        mb[name] = chr(k) if n == 1 else [chr(k + i) for i in range(n)]
        k += n
    hud["mb"] = mb
    lines = ["# Generated: draws one HUD heart per Chaos Heart held (up to 3 of a type)."]
    for i, h, *_ in TYPES:
        for c in range(1, 4):
            lines.append(f"execute if score @s ch.cnt.{h} matches {c}.. run function ch:core/hud/heart {{i:{i}}}")
    fn("gen/hud_hearts", lines)
    lines = ["# Generated: mastery dock numbers of the active heart: #mx XP, #ma Ascension XP, #mp skill points."]
    for i, h, *_ in TYPES:
        lines.append(f"execute if score @s ch.active matches {i} run scoreboard players operation #mx ch.tmp = @s ch.xp.{h}")
        lines.append(f"execute if score @s ch.active matches {i} run scoreboard players operation #ma ch.tmp = @s ch.asc.{h}")
        lines.append(f"execute if score @s ch.active matches {i} run scoreboard players operation #mp ch.tmp = @s ch.pts.{h}")
    fn("gen/mb_xp", lines)

    # ---- admin panel: heart index -> name, and the per-heart buttons for the picked player (tag ch.adtgt)
    lines = ["# Generated: runs $(f) {heart:\"<name>\"} for heart index #ai ch.tmp."]
    for i, h, *_ in TYPES:
        lines.append(f"$execute if score #ai ch.tmp matches {i} run return run function $(f) {{heart:\"{h}\"}}")
    fn("gen/admin_heart", lines)
    lines = ["# Generated: give / take / make-active buttons on the admin player page."]
    for i, h, name, *_ in TYPES:
        lines.append(f"function ch:admin/ui/btn {{l:\"+ Give {name}\",c:{2000 + i}}}")
    for i, h, name, *_ in TYPES:
        lines.append(f"execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.{h} matches 1.. run function ch:admin/ui/btn {{l:\"− Take {name}\",c:{2100 + i}}}")
    for i, h, name, *_ in TYPES:
        lines.append(f"execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.{h} matches 1.. unless score @a[tag=ch.adtgt,limit=1] ch.active matches {i} run function ch:admin/ui/btn {{l:\"◆ Make {name} active\",c:{2200 + i}}}")
    fn("gen/admin_buttons", lines)
    lines = ["# Generated: one row of mastery buttons (0 25 50 75 100, awaken) per heart the picked player holds."]
    for i, h, name, *_ in TYPES:
        cond = f"execute if score @a[tag=ch.adtgt,limit=1] ch.cnt.{h} matches 1.. run "
        for lvl in (0, 25, 50, 75, 100):
            label = f"{name} {lvl}" if lvl == 0 else str(lvl)
            lines.append(cond + f"function ch:admin/ui/btn {{l:\"{label}\",c:{10000 + i * 1000 + lvl}}}")
        lines.append(cond + f"function ch:admin/ui/btn {{l:\"Awaken\",c:{3000 + i}}}")
    fn("gen/admin_mastery_buttons", lines)
    fn("gen/hud_tables", ["# Generated: HUD glyph characters and pixel spaces (sp[n+200] moves the pen n pixels).",
                          f"data modify storage ch:const hud set value {snbt(hud)}"])

    # ---- menu text for each heart (abilities, passives, branches) kept in storage for the dialogs
    menu = {}
    for i, h, name, col, _ in TYPES:
        m = json.loads(json.dumps(HEARTS[h]))
        ov_path = os.path.join(ROOT, "tools", "kits", f"{h}.json")
        if os.path.exists(ov_path):
            ov = json.load(open(ov_path, encoding="utf-8"))
            for n, a in enumerate(ov.get("abilities", [])[:4]):
                m["abilities"][n].update({k: v for k, v in a.items() if k in ("desc", "variants")})
            for k in ("p1d", "p2d", "awd"):
                if k in ov:
                    m[k] = ov[k]
        menu[h] = {
            "title": name, "color": col, "lore": LORE[h], "i": i,
            "a": [{"name": a["name"], "desc": a["desc"], "var": a.get("variants", ""), "cd": a["cd"], "unlock": UNLOCK[n]} for n, a in enumerate(m["abilities"])],
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

    # ---- the Awakening Altar: barrier blocks (unbreakable, blast proof) dressed in block displays
    disp = []

    def block(dx, dy, dz, b):
        disp.append(f'summon block_display ~{dx} ~{dy} ~{dz} {{Tags:["ch.altarpart","ch.noability"],block_state:{{Name:"minecraft:{b}"}}}}')
    for dx in range(-4, 5):
        for dz in range(-4, 5):
            a, c = abs(dx), abs(dz)
            if a == 4 and c == 4:
                b = "chiseled_polished_blackstone"
            elif a == 4 or c == 4:
                b = "polished_blackstone_bricks"
            elif (a == 3 and c == 0) or (a == 0 and c == 3):
                b = "crying_obsidian"
            elif a == 3 or c == 3:
                b = "polished_blackstone"
            else:
                b = "blackstone"
            block(dx, 0, dz, b)
    for dx in range(-2, 3):
        for dz in range(-2, 3):
            a, c = abs(dx), abs(dz)
            if a == 0 and c == 0:
                b = "reinforced_deepslate"
            elif a == 2 or c == 2:
                b = "deepslate_tiles"
            elif a == 1 and c == 1:
                b = "gilded_blackstone"
            else:
                b = "polished_deepslate"
            block(dx, 1, dz, b)
    for sx in (-4, 4):
        for sz in (-4, 4):
            block(sx, 1, sz, "polished_blackstone_wall")
            block(sx, 2, sz, "polished_blackstone_wall")
            block(sx, 3, sz, "crying_obsidian")
            block(sx, 4, sz, "soul_lantern")
    lines = ["# Generated: builds the Awakening Altar at the aligned position (its south-west base corner is ~-4 ~ ~-4).",
             "fill ~-4 ~ ~-4 ~4 ~ ~4 minecraft:barrier",
             "fill ~-2 ~1 ~-2 ~2 ~1 ~2 minecraft:barrier",
             "fill ~-4 ~1 ~-4 ~-4 ~3 ~-4 minecraft:barrier", "fill ~4 ~1 ~-4 ~4 ~3 ~-4 minecraft:barrier",
             "fill ~-4 ~1 ~4 ~-4 ~3 ~4 minecraft:barrier", "fill ~4 ~1 ~4 ~4 ~3 ~4 minecraft:barrier",
             "fill ~-3 ~1 ~-3 ~3 ~6 ~3 minecraft:air replace #ch:passable",
             "setblock ~-4 ~4 ~-4 minecraft:light[level=12]", "setblock ~4 ~4 ~-4 minecraft:light[level=12]",
             "setblock ~-4 ~4 ~4 minecraft:light[level=12]", "setblock ~4 ~4 ~4 minecraft:light[level=12]"]
    lines += disp
    for k, (i, h, *_rest) in enumerate(TYPES):
        lines.append(
            f'summon item_display ~0.5 ~3.4 ~0.5 {{Tags:["ch.altarpart","ch.altar_gem","ch.noability"],Rotation:[{k * 36}f,0f],'
            f'teleport_duration:40,brightness:{{sky:15,block:15}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],'
            f'translation:[0f,0f,2.3f],scale:[0.7f,0.7f,0.7f]}},item:{{id:"minecraft:paper",count:1,components:{{"minecraft:item_model":"chaoshearts:heart_{h}"}}}}}}')
    lines += [
        'summon item_display ~0.5 ~4.6 ~0.5 {Tags:["ch.altarpart","ch.altar_crystal","ch.noability"],brightness:{sky:15,block:15},interpolation_duration:40,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.6f,1.6f,1.6f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:altar_crystal","minecraft:custom_model_data":{colors:[12602623]}}}}',
        'summon item_display ~0.5 ~2.03 ~0.5 {Tags:["ch.altarpart","ch.altar_rune","ch.noability"],brightness:{sky:15,block:15},interpolation_duration:40,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[4.6f,4.6f,4.6f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:altar_rune","minecraft:custom_model_data":{colors:[9061631]}}}}',
        'summon text_display ~0.5 ~6.6 ~0.5 {Tags:["ch.altarpart","ch.noability"],billboard:"center",background:0,shadow:true,text:[{text:"Awakening Altar",color:"light_purple",bold:true},{text:"\\nRight-click the crystal to face a trial",color:"gray"}]}',
        'summon interaction ~0.5 ~2 ~0.5 {Tags:["ch.altarpart","ch.altar_i","ch.noability"],width:3.0f,height:3.5f,response:true}',
        'summon marker ~0.5 ~2 ~0.5 {Tags:["ch.altar","ch.altarpart","ch.noability"]}',
    ]
    fn("gen/altar_build", lines)

    lines = ["# Generated: the hearts list in the menu."]
    for i, h, *_ in TYPES:
        lines.append(f"execute if score @s ch.cnt.{h} matches 1.. run function ch:menu/heart_line {{h:\"{h}\",i:{i}}}")
    fn("gen/menu_hearts", lines)

    # trial content dispatch: runs the active trial's function for heart #hid ch.tmp
    for f, args in (("build", ""), ("intro", ""), ("wave", " with storage ch:tmp tw"), ("boss_spawn", ""),
                    ("boss_tick", ""), ("phase", " with storage ch:tmp tw"), ("ambient", "")):
        lines = [f"# Generated: runs trials/<heart>/{f} for the trial of heart #hid ch.tmp."]
        for i, h, *_ in TYPES:
            lines.append(f"execute if score #hid ch.tmp matches {i} run return run function ch:trials/{h}/{f}{args}")
        fn(f"gen/trial_{f}", lines)

    n_sig = vfx_signatures.write_signatures(fn, TYPES)
    print(f"{n_sig} signature VFX functions")
    print(f"{n_shapes} VFX shapes ({n_pts} particle points)")
    print("datapack generated in", DP)


if __name__ == "__main__":
    gen()
