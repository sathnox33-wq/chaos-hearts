#!/usr/bin/env python3
"""Sanity checks for the generated resource pack (run after tools/gen_assets.py).

    python3 tools/check_resourcepack.py

Checks that all JSON parses, every model an item definition names exists, every texture a model or font
names exists, model elements stay in bounds with legal rotations, font glyphs have the sizes declared in
tools/glyphs.json (and keep their full advance), animations divide evenly, and every sound file exists.
"""
import json
import os
import sys

from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PACK = os.path.join(ROOT, "resourcepack")
ASSETS = os.path.join(PACK, "assets")
errors = []


def err(msg):
    errors.append(msg)


def res_path(rid, kind, ext):
    ns, path = rid.split(":", 1) if ":" in rid else ("minecraft", rid)
    return os.path.join(ASSETS, ns, kind, path + ext), ns


def load(path):
    with open(path, encoding="utf-8") as f:
        return json.load(f)


# ---- every JSON parses
jsons = {}
for d, _, files in os.walk(PACK):
    for f in files:
        if f.endswith((".json", ".mcmeta")):
            p = os.path.join(d, f)
            try:
                jsons[p] = load(p)
            except Exception as e:  # noqa: BLE001
                err(f"bad JSON {p}: {e}")

meta = jsons.get(os.path.join(PACK, "pack.mcmeta"), {}).get("pack", {})
if meta.get("min_format") != 75 or meta.get("max_format") != 75 or meta.get("pack_format", 75) != 75:
    err(f"pack.mcmeta formats wrong: {meta}")
if not os.path.isfile(os.path.join(PACK, "pack.png")):
    err("pack.png missing")
if os.path.isdir(os.path.join(ASSETS, "minecraft", "items")):
    err("assets/minecraft/items overrides should be gone")
for d, _, files in os.walk(PACK):
    for f in files:
        if "focus" in f:
            err(f"focus art left: {os.path.join(d, f)}")


# ---- textures and animations
def check_texture(rid, who):
    p, ns = res_path(rid, "textures", ".png")
    if ns == "minecraft":
        return
    if not os.path.isfile(p):
        err(f"{who}: texture {rid} missing")
        return
    m = p + ".mcmeta"
    if os.path.isfile(m):
        a = load(m).get("animation", {})
        w, h = Image.open(p).size
        fw = a.get("width", w)
        fh = a.get("height", fw if "width" in a else w)
        if w % fw or h % fh:
            err(f"{p}: {w}x{h} does not divide into {fw}x{fh} frames")


# ---- models
ROT_OK = {-45, -22.5, 0, 22.5, 45}
checked_models = set()


def check_model(rid, who):
    if rid in checked_models:
        return
    checked_models.add(rid)
    p, ns = res_path(rid, "models", ".json")
    if ns == "minecraft":
        return
    if not os.path.isfile(p):
        err(f"{who}: model {rid} missing")
        return
    m = load(p)
    tex = dict(m.get("textures", {}))
    if "parent" in m:
        check_model(m["parent"], rid)
    for k, v in tex.items():
        if not v.startswith("#"):
            check_texture(v, rid)
    for i, e in enumerate(m.get("elements", [])):
        for c in e["from"] + e["to"]:
            if not -16 <= c <= 32:
                err(f"{rid} element {i}: coordinate {c} outside -16..32")
        r = e.get("rotation")
        if r:
            if r["angle"] not in ROT_OK or r["axis"] not in ("x", "y", "z"):
                err(f"{rid} element {i}: bad rotation {r}")
        if not e.get("faces"):
            err(f"{rid} element {i}: no faces")
        for fn, f in e.get("faces", {}).items():
            key = f["texture"].lstrip("#")
            seen = set()
            while key in tex and tex[key].startswith("#") and key not in seen:
                seen.add(key)
                key = tex[key].lstrip("#")
            if key not in tex:
                err(f"{rid} element {i} face {fn}: texture #{key} not defined")


def walk_item_model(node, who):
    if isinstance(node, dict):
        if node.get("type") in ("minecraft:model", "model") and "model" in node:
            check_model(node["model"], who)
        for v in node.values():
            walk_item_model(v, who)
    elif isinstance(node, list):
        for v in node:
            walk_item_model(v, who)


items_dir = os.path.join(ASSETS, "chaoshearts", "items")
item_ids = []
for d, _, files in os.walk(items_dir):
    for f in files:
        p = os.path.join(d, f)
        rid = "chaoshearts:" + os.path.relpath(p, items_dir)[:-5].replace(os.sep, "/")
        item_ids.append(rid)
        walk_item_model(jsons[p], rid)
models_dir = os.path.join(ASSETS, "chaoshearts", "models")
for d, _, files in os.walk(models_dir):
    for f in files:
        rid = "chaoshearts:" + os.path.relpath(os.path.join(d, f), models_dir)[:-5].replace(os.sep, "/")
        check_model(rid, "(all models)")

# ---- fonts
glyphs = load(os.path.join(ROOT, "tools", "glyphs.json"))
declared = {}  # char -> (visible height, ascent, scale-1 required)
hg = glyphs["hearts"]
for i in range(10):
    for k in hg["states"].values():
        declared[chr(int(hg["base"], 16) + i * 8 + k)] = (hg["height"], None, True)
ab = glyphs["abilities"]
for i in range(40):
    declared[chr(int(ab["base"], 16) + i)] = (ab["height"], ab["ascent"], True)
for code in glyphs["ability_extra"]["glyphs"].values():
    declared[chr(int(code, 16))] = (glyphs["ability_extra"]["height"], glyphs["ability_extra"]["ascent"], True)
for n in range(10):
    declared[chr(int(glyphs["digits"]["base"], 16) + n)] = (glyphs["digits"]["height"], glyphs["digits"]["ascent"], True)
for n in range(21):
    declared[chr(int(glyphs["meter"]["base"], 16) + n)] = (glyphs["meter"]["height"], glyphs["meter"]["ascent"], True)
for code in glyphs["overlays"]["glyphs"].values():
    declared[chr(int(code, 16))] = (glyphs["overlays"]["height"], glyphs["overlays"]["ascent"], False)

space_adv = {chr(int(k, 16)): v for k, v in glyphs["space"]["advances"].items()}
font_dir = os.path.join(ASSETS, "chaoshearts", "font")
expected_fonts = {"hud", "hud_r10", "hud_r9", "hud_r8", "hud_r7", "hud_num", "hud_meter", "overlay"}
found = {f[:-5] for f in os.listdir(font_dir)} if os.path.isdir(font_dir) else set()
for f in expected_fonts - found:
    err(f"font {f} missing")
seen_chars = {}
for name in sorted(found):
    provs = jsons[os.path.join(font_dir, name + ".json")]["providers"]
    if name.startswith("hud"):
        sp = [p for p in provs if p["type"] == "space"]
        if not sp or sp[0]["advances"] != space_adv:
            err(f"font {name}: space provider missing or different from glyphs.json")
    for p in provs:
        if p["type"] != "bitmap":
            continue
        tp, _ = res_path(p["file"][:-4] if p["file"].endswith(".png") else p["file"], "textures", ".png")
        if not os.path.isfile(tp):
            err(f"font {name}: {p['file']} missing")
            continue
        if p["ascent"] > p["height"]:
            err(f"font {name}: ascent {p['ascent']} > height {p['height']} (Minecraft rejects this)")
        im = Image.open(tp).convert("RGBA")
        rows = p["chars"]
        cols = len(rows[0])
        w, h = im.size
        gw, gh = w // cols, h // len(rows)
        for r, row in enumerate(rows):
            for c, ch in enumerate(row):
                seen_chars.setdefault(name, set()).add(ch)
                cell = im.crop((c * gw, r * gh, (c + 1) * gw, (r + 1) * gh))
                if ch not in declared:
                    err(f"font {name}: U+{ord(ch):04X} not in glyphs.json")
                    continue
                vis, asc, scale1 = declared[ch]
                if asc is not None and p["ascent"] != asc:
                    err(f"font {name}: U+{ord(ch):04X} ascent {p['ascent']} != glyphs.json {asc}")
                if scale1:
                    if gh != p["height"]:
                        err(f"font {name}: U+{ord(ch):04X} texture height {gh} != glyph height {p['height']} (not scale 1)")
                    bbox = cell.getchannel("A").point(lambda a: 255 if a > 1 else 0).getbbox()
                    if bbox and bbox[3] > vis:
                        err(f"font {name}: U+{ord(ch):04X} draws below its declared {vis}px")
                    if cell.getchannel("A").crop((gw - 1, 0, gw, gh)).getextrema()[1] < 1:
                        err(f"font {name}: U+{ord(ch):04X} last column empty (advance would be trimmed)")
                else:
                    if abs(gh / p["height"] - 2) > 1e-6:
                        err(f"font {name}: overlay U+{ord(ch):04X} is {gw}x{gh}, expected 2x of height {p['height']}")
for name in ("hud_r10", "hud_r9", "hud_r8", "hud_r7"):
    if len(seen_chars.get(name, ())) != 60:
        err(f"font {name}: {len(seen_chars.get(name, ()))} heart glyphs, expected 60")
if len(seen_chars.get("hud", ())) != 40 + len(glyphs["ability_extra"]["glyphs"]):
    err(f"font hud: {len(seen_chars.get('hud', ()))} glyphs")

# ---- sounds and lang
sounds = jsons.get(os.path.join(ASSETS, "chaoshearts", "sounds.json"), {})
lang = jsons.get(os.path.join(ASSETS, "chaoshearts", "lang", "en_us.json"), {})
for ev, d in sounds.items():
    for s in d["sounds"]:
        nm = s["name"] if isinstance(s, dict) else s
        p, _ = res_path(nm, "sounds", ".ogg")
        if not os.path.isfile(p):
            err(f"sound {ev}: {nm} missing")
    if "subtitle" in d and d["subtitle"] not in lang:
        err(f"sound {ev}: subtitle key {d['subtitle']} not in lang")

print(f"{len(jsons)} JSON files, {len(checked_models)} models, {len(item_ids)} item definitions, "
      f"{len(sounds)} sound events, {sum(len(v) for v in seen_chars.values())} font glyphs checked")
if errors:
    print(f"{len(errors)} problem(s):")
    for e in errors[:200]:
        print("  " + e)
    sys.exit(1)
print("resource pack OK")
