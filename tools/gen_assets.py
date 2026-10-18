#!/usr/bin/env python3
"""
Generates the Chaos Hearts resource pack from scratch: textures, models, item
definitions, sound definitions, synthesized sound effects and trial music.

Everything is procedural and seeded, so running it again produces the same pack.

    python3 tools/gen_assets.py            # writes ./resourcepack and the mod icon

Needs numpy, Pillow and an ffmpeg build with libvorbis on PATH.
"""
import json
import math
import os
import shutil
import subprocess
import sys
import tempfile
import wave

import numpy as np
from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PACK = os.path.join(ROOT, "resourcepack")
ICON = os.path.join(ROOT, "src", "main", "resources", "assets", "chaoshearts", "icon.png")
SR = 44100

# id, main colour, secondary colour (mirrors HeartType.java)
HEARTS = [
    ("rage", 0xE0262B, 0x5A0A0A),
    ("speed", 0xF5E142, 0x29D3F2),
    ("infernal", 0xFF7A1A, 0x8C1C00),
    ("void", 0x8A3CFF, 0x14002B),
    ("frozen", 0x9BE7FF, 0x2F6FA8),
    ("storm", 0x4FA8FF, 0xE8F6FF),
    ("blood", 0x9E0B1F, 0x2B0006),
    ("titan", 0xC9A45C, 0x5B5348),
    ("celestial", 0xFFF2B0, 0xFFC94A),
    ("corruption", 0x7BD13A, 0x3D1A52),
]


def rgb(c):
    return np.array([(c >> 16) & 255, (c >> 8) & 255, c & 255], dtype=np.float64)


def write_json(path, data):
    full = os.path.join(PACK, path)
    os.makedirs(os.path.dirname(full), exist_ok=True)
    with open(full, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)
        f.write("\n")


# =====================================================================  textures

N = 32


def heart_field(size, scale=1.0, cx=0.0, cy=0.0):
    """Signed-ish implicit heart value per pixel; <= 0 inside."""
    ys, xs = np.mgrid[0:size, 0:size].astype(np.float64)
    x = ((xs + 0.5) / size - 0.5) * 2.7 / scale - cx
    y = -(((ys + 0.5) / size - 0.5) * 2.7 / scale - cy) + 0.15
    return (x * x + y * y - 1) ** 3 - x * x * y ** 3, x, y


def outline(mask):
    m = mask
    grown = m.copy()
    grown[1:, :] |= m[:-1, :]
    grown[:-1, :] |= m[1:, :]
    grown[:, 1:] |= m[:, :-1]
    grown[:, :-1] |= m[:, 1:]
    return grown & ~m


def shade_heart(main, sec, scale, rng, glow=0.0):
    f, x, y = heart_field(N, scale)
    inside = f <= 0
    a, b = rgb(main), rgb(sec)
    # light from the upper left, darker towards the bottom tip
    t = np.clip(0.5 + 0.35 * (x * -0.6 + y * 0.8), 0, 1)
    col = b[None, None, :] * (1 - t[..., None]) + a[None, None, :] * t[..., None]
    rim = np.clip(-f * 4, 0, 1)
    col = col * (0.55 + 0.45 * rim[..., None])
    col += glow * 60
    # specular highlight
    hl = np.exp(-(((x + 0.45) ** 2) + ((y - 0.55) ** 2)) * 18)
    col += hl[..., None] * 170
    # a little dither so it reads as a gem, not a flat blob
    col += rng.normal(0, 6, col.shape)
    img = np.zeros((N, N, 4))
    img[..., :3] = np.clip(col, 0, 255)
    img[..., 3] = inside * 255
    edge = outline(inside)
    dark = np.clip(b * 0.35, 0, 255)
    img[edge] = [dark[0], dark[1], dark[2], 255]
    return img, inside, x, y


def put(img, px, py, c, alpha=255):
    if 0 <= px < N and 0 <= py < N:
        c = np.asarray(c, dtype=np.float64)
        if img[py, px, 3] == 0:
            img[py, px, :3] = c
            img[py, px, 3] = alpha
        else:
            k = alpha / 255.0
            img[py, px, :3] = img[py, px, :3] * (1 - k) + c * k
            img[py, px, 3] = max(img[py, px, 3], alpha)


def motif(img, inside, kind, main, sec, rng, phase=0.0):
    """Small pixel-art emblem per heart type, drawn on the heart's face."""
    light = np.clip(rgb(main) * 0.4 + 160, 0, 255)
    dark = np.clip(rgb(sec) * 0.5, 0, 255)
    cx, cy = 16, 15

    def p(x, y, c, a=255):
        if 0 <= y < N and 0 <= x < N and inside[y, x]:
            put(img, x, y, c, a)

    if kind == "rage":  # furious brows, burning eyes and a fanged grin
        for i in range(4):
            p(10 + i, 10 + i // 2, dark); p(21 - i, 10 + i // 2, dark)
        for x, y in ((12, 14), (13, 14), (19, 14), (18, 14)):
            p(x, y, (255, 220, 120))
        for x in range(12, 21):
            p(x, 18, dark)
        for x in (13, 15, 17, 19):
            p(x, 19, (255, 240, 220))
    elif kind == "speed":  # motion streaks and a chevron
        for row, ln in ((11, 9), (15, 12), (19, 7)):
            for x in range(cx - ln // 2, cx + ln // 2):
                p(x, row, light, 200)
        for i in range(4):
            p(cx + 2 + i, cy - 3 + i, (255, 255, 255)); p(cx + 2 + i, cy + 3 - i, (255, 255, 255))
    elif kind == "infernal":  # a flame tongue
        for y in range(9, 22):
            w = int(4 * math.sin((y - 8) / 14 * math.pi)) + 1
            off = int(1.5 * math.sin(y * 0.8 + phase * 6))
            for x in range(cx - w + off, cx + w + off):
                c = (255, 230, 120) if abs(x - cx - off) < w // 2 else (255, 140, 40)
                p(x, y, c, 220)
    elif kind == "void":  # a swirl around a black core
        for k in range(60):
            ang = k * 0.35 + phase * 6.28
            r = 1.5 + k * 0.12
            p(int(cx + math.cos(ang) * r), int(cy + math.sin(ang) * r), light, 180)
        for dx in range(-2, 3):
            for dy in range(-2, 3):
                if dx * dx + dy * dy <= 5:
                    p(cx + dx, cy + dy, (6, 0, 14))
    elif kind == "frozen":  # a snowflake
        for d in range(-6, 7):
            p(cx + d, cy, light); p(cx, cy + d, light)
            if abs(d) < 5:
                p(cx + d, cy + d, (255, 255, 255), 200); p(cx + d, cy - d, (255, 255, 255), 200)
    elif kind == "storm":  # a lightning bolt
        pts = [(19, 7), (14, 14), (18, 14), (12, 23)]
        for (x0, y0), (x1, y1) in zip(pts, pts[1:]):
            steps = max(abs(x1 - x0), abs(y1 - y0))
            for s in range(steps + 1):
                x = round(x0 + (x1 - x0) * s / steps); y = round(y0 + (y1 - y0) * s / steps)
                p(x, y, (255, 255, 230)); p(x + 1, y, (255, 240, 120), 200)
    elif kind == "blood":  # drips running down
        for x0, ln in ((11, 6), (15, 9), (19, 5), (22, 3)):
            for y in range(7, 7 + ln):
                p(x0, y, (60, 0, 8))
            p(x0, 7 + ln, (30, 0, 4)); p(x0 - 1, 6 + ln, (60, 0, 8)); p(x0 + 1, 6 + ln, (60, 0, 8))
    elif kind == "titan":  # cracks across stone
        r = np.random.default_rng(7)
        for start in ((9, 10), (22, 9), (16, 20)):
            x, y = start
            for _ in range(8):
                p(x, y, dark)
                x += int(r.integers(-1, 2)); y += int(r.integers(-1, 2))
        for x in range(12, 21):
            p(x, 14, (240, 220, 170), 120)
    elif kind == "celestial":  # a four point star
        for d in range(-6, 7):
            a = int(255 * (1 - abs(d) / 7))
            p(cx + d, cy, (255, 255, 255), a); p(cx, cy + d, (255, 255, 255), a)
        for d in range(-2, 3):
            p(cx + d, cy + d, (255, 250, 200), 200); p(cx + d, cy - d, (255, 250, 200), 200)
    elif kind == "corruption":  # spores and veins
        r = np.random.default_rng(11)
        for _ in range(9):
            x, y = int(r.integers(9, 24)), int(r.integers(8, 22))
            p(x, y, (190, 255, 120)); p(x + 1, y, dark)
        for k in range(18):
            p(10 + k // 2 + int(2 * math.sin(k * 0.7 + phase * 6)), 9 + int(k / 1.5), dark, 200)


def frame_ring(img, metal, rng):
    """Amulet setting that marks a focus (the casting item) apart from a raw heart."""
    ys, xs = np.mgrid[0:N, 0:N].astype(np.float64)
    d = np.hypot(xs + 0.5 - 16, ys + 0.5 - 16)
    ring = (d > 13.0) & (d <= 15.2)
    m = rgb(metal)
    t = 0.6 + 0.4 * np.cos(np.arctan2(ys - 16, xs - 16) + 2.3)
    for yy, xx in zip(*np.nonzero(ring)):
        if img[yy, xx, 3] == 0:
            c = np.clip(m * t[yy, xx] + rng.normal(0, 5), 0, 255)
            img[yy, xx] = [c[0], c[1], c[2], 255]
    # bail at the top so it reads as a pendant
    for x in range(14, 18):
        for y in range(0, 3):
            if img[y, x, 3] == 0 or y < 2:
                img[y, x] = [*(np.clip(m * 0.8, 0, 255)), 255]
    # gem sockets at the sides
    for x, y in ((1, 16), (30, 16), (16, 30)):
        img[y, x] = [255, 255, 255, 255]


def sparkle(img, rng, n, color, phase):
    for k in range(n):
        ang = phase * 6.283 + k * 6.283 / n
        r = 11 + 2 * math.sin(phase * 12.56 + k)
        x = int(16 + math.cos(ang) * r); y = int(16 + math.sin(ang) * r)
        for dx, dy, a in ((0, 0, 255), (1, 0, 140), (-1, 0, 140), (0, 1, 140), (0, -1, 140)):
            put(img, x + dx, y + dy, color, a)


def to_image(arr):
    return Image.fromarray(np.clip(arr, 0, 255).astype(np.uint8), "RGBA")


def save_texture(path, frames, frametime=None):
    full = os.path.join(PACK, "assets", "chaoshearts", "textures", path + ".png")
    os.makedirs(os.path.dirname(full), exist_ok=True)
    if len(frames) == 1:
        to_image(frames[0]).save(full)
        return
    strip = np.concatenate(frames, axis=0)
    to_image(strip).save(full)
    with open(full + ".mcmeta", "w") as f:
        json.dump({"animation": {"frametime": frametime, "interpolate": True}}, f, indent=2)


def heart_textures():
    for kind, main, sec in HEARTS:
        rng = np.random.default_rng(sum(map(ord, kind)))
        # token: a raw heart that beats
        frames = []
        for i in range(6):
            beat = [1.0, 1.06, 1.0, 1.03, 1.0, 1.0][i]
            img, inside, _, _ = shade_heart(main, sec, 0.92 * beat, np.random.default_rng(i), glow=0.15 * (beat - 1) * 10)
            motif(img, inside, kind, main, sec, rng, phase=i / 6)
            frames.append(img)
        save_texture(f"item/heart_{kind}", frames, 3)

        # focus: the heart set in an amulet
        img, inside, _, _ = shade_heart(main, sec, 0.74, np.random.default_rng(1))
        motif(img, inside, kind, main, sec, rng)
        frame_ring(img, 0x9C9CA8, rng)
        save_texture(f"item/focus_{kind}", [img])

        # awakened focus: gold setting, a glowing heart, orbiting sparks
        frames = []
        for i in range(8):
            ph = i / 8
            glow = 0.35 + 0.35 * math.sin(ph * 6.283)
            img, inside, _, _ = shade_heart(main, sec, 0.76, np.random.default_rng(i + 3), glow=glow)
            motif(img, inside, kind, main, sec, rng, phase=ph)
            frame_ring(img, 0xF2C84B, rng)
            sparkle(img, rng, 3, np.clip(rgb(main) * 0.3 + 180, 0, 255), ph)
            frames.append(img)
        save_texture(f"item/focus_{kind}_awakened", frames, 2)


def eye_textures():
    rng = np.random.default_rng(66)
    S = 32
    ys, xs = np.mgrid[0:S, 0:S].astype(np.float64)
    # sclera, sickly and veined
    sclera = np.zeros((S, S, 4))
    base = np.array([214, 204, 190.0])
    sclera[..., :3] = base + rng.normal(0, 7, (S, S, 3))
    sclera[..., 3] = 255
    for _ in range(14):
        x, y = rng.uniform(0, S), rng.uniform(0, S)
        ang = rng.uniform(0, 6.28)
        for step in range(int(rng.integers(6, 16))):
            ix, iy = int(x) % S, int(y) % S
            sclera[iy, ix, :3] = [150 + rng.integers(-20, 20), 20, 30]
            ang += rng.normal(0, 0.6)
            x += math.cos(ang); y += math.sin(ang)
    # darken towards the edges of each face so the cube reads as round
    d = np.maximum(np.abs(xs - 15.5), np.abs(ys - 15.5)) / 16
    sclera[..., :3] *= (1 - 0.45 * d ** 2)[..., None]
    save_texture("entity/the_eye_sclera", [sclera])

    # iris: burning violet-crimson with a slit pupil, animated so it seems alive
    frames = []
    for i in range(8):
        ph = i / 8
        img = sclera.copy()
        r = np.hypot(xs - 15.5, ys - 15.5)
        ang = np.arctan2(ys - 15.5, xs - 15.5)
        iris = r < 12.5
        fib = 0.5 + 0.5 * np.sin(ang * 22 + r * 0.8 + ph * 6.28)
        inner = np.array([255, 70, 40.0]); outer = np.array([110, 10, 160.0])
        t = np.clip(r / 12.5, 0, 1)[..., None]
        col = inner * (1 - t) + outer * t
        col *= (0.7 + 0.3 * fib)[..., None]
        img[iris, :3] = col[iris]
        ring = (r >= 11.5) & (r < 12.8)
        img[ring, :3] = [30, 0, 30]
        dil = 2.2 + 0.8 * math.sin(ph * 6.28)
        pupil = (np.abs(xs - 15.5) < dil) & (np.abs(ys - 15.5) < 10.5 - np.abs(xs - 15.5) * 0.8)
        img[pupil, :3] = [5, 0, 8]
        glint = np.hypot(xs - 11.5, ys - 10.5) < 1.6
        img[glint, :3] = [255, 240, 240]
        frames.append(img)
    save_texture("entity/the_eye_iris", frames, 4)


def models():
    for kind, _, _ in HEARTS:
        for name in (f"heart_{kind}", f"focus_{kind}", f"focus_{kind}_awakened"):
            write_json(f"assets/chaoshearts/models/item/{name}.json", {
                "parent": "minecraft:item/generated",
                "textures": {"layer0": f"chaoshearts:item/{name}"},
            })

    sc, ir = "#sclera", "#iris"
    full = {"uv": [0, 0, 16, 16]}
    write_json("assets/chaoshearts/models/item/the_eye.json", {
        "textures": {"sclera": "chaoshearts:entity/the_eye_sclera", "iris": "chaoshearts:entity/the_eye_iris",
                     "particle": "chaoshearts:entity/the_eye_sclera"},
        "elements": [
            # core of the eyeball; the iris is on both the front and back so it looks at you from either way the display faces
            {"from": [1, 1, 1], "to": [15, 15, 15], "shade": False, "faces": {
                "north": {**full, "texture": ir}, "south": {**full, "texture": ir},
                "east": {**full, "texture": sc}, "west": {**full, "texture": sc},
                "up": {**full, "texture": sc}, "down": {**full, "texture": sc}}},
            # rounding bands so the silhouette is less of a cube
            {"from": [0, 3, 3], "to": [16, 13, 13], "shade": False, "faces": {
                "east": {**full, "texture": sc}, "west": {**full, "texture": sc},
                "up": {**full, "texture": sc}, "down": {**full, "texture": sc}}},
            {"from": [3, 0, 3], "to": [13, 16, 13], "shade": False, "faces": {
                "north": {**full, "texture": sc}, "south": {**full, "texture": sc},
                "east": {**full, "texture": sc}, "west": {**full, "texture": sc},
                "up": {**full, "texture": sc}, "down": {**full, "texture": sc}}},
            # bulging cornea over the iris, front and back
            {"from": [3, 3, 0.4], "to": [13, 13, 15.6], "shade": False, "faces": {
                "north": {**full, "texture": ir}, "south": {**full, "texture": ir}}},
        ],
        "display": {
            "fixed": {"rotation": [0, 0, 0], "translation": [0, 0, 0], "scale": [1, 1, 1]},
            "gui": {"rotation": [20, 35, 0], "scale": [0.6, 0.6, 0.6]},
            "ground": {"scale": [0.4, 0.4, 0.4], "translation": [0, 3, 0]},
            "thirdperson_righthand": {"rotation": [75, 45, 0], "translation": [0, 2.5, 0], "scale": [0.375, 0.375, 0.375]},
            "firstperson_righthand": {"rotation": [0, 45, 0], "scale": [0.4, 0.4, 0.4]},
        },
    })


def item_definitions():
    cases = []
    for kind, _, _ in HEARTS:
        for name in (f"focus_{kind}", f"focus_{kind}_awakened", f"heart_{kind}"):
            cases.append({"when": f"chaoshearts:{name}",
                          "model": {"type": "minecraft:model", "model": f"chaoshearts:item/{name}"}})
    write_json("assets/minecraft/items/heart_of_the_sea.json", {"model": {
        "type": "minecraft:select", "property": "minecraft:custom_model_data", "index": 0,
        "cases": cases,
        "fallback": {"type": "minecraft:model", "model": "minecraft:item/heart_of_the_sea"}}})
    write_json("assets/minecraft/items/ender_eye.json", {"model": {
        "type": "minecraft:select", "property": "minecraft:custom_model_data", "index": 0,
        "cases": [{"when": "chaoshearts:the_eye", "model": {"type": "minecraft:model", "model": "chaoshearts:item/the_eye"}}],
        "fallback": {"type": "minecraft:model", "model": "minecraft:item/ender_eye"}}})


def mod_icon():
    big = 128
    img, inside, _, _ = shade_heart(0x8A3CFF, 0x14002B, 0.8, np.random.default_rng(2), glow=0.3)
    # split the heart into the ten colours like a stained glass window
    f, x, y = heart_field(N, 0.8)
    ang = (np.arctan2(y, x) + math.pi) / (2 * math.pi)
    for i, (_, main, sec) in enumerate(HEARTS):
        sel = inside & (np.floor(ang * 10) == i)
        t = np.clip(0.5 + 0.4 * y, 0, 1)
        col = rgb(main)[None, :] * t[sel][:, None] + rgb(sec)[None, :] * (1 - t[sel][:, None]) * 0.6
        img[sel, :3] = np.clip(col + 30, 0, 255)
    img[outline(inside)] = [20, 0, 30, 255]
    hl = np.exp(-(((x + 0.45) ** 2) + ((y - 0.55) ** 2)) * 18)
    img[..., :3] = np.clip(img[..., :3] + (hl * 160 * inside)[..., None], 0, 255)
    os.makedirs(os.path.dirname(ICON), exist_ok=True)
    to_image(img).resize((big, big), Image.NEAREST).save(ICON)
    to_image(img).resize((128, 128), Image.NEAREST).save(os.path.join(PACK, "pack.png"))


# =====================================================================  audio

def t_axis(dur):
    return np.arange(int(dur * SR)) / SR


def env(n, a=0.005, d=0.3, curve=3.0):
    """Attack then exponential-ish decay over n samples."""
    t = np.arange(n) / SR
    at = np.clip(t / max(a, 1e-4), 0, 1)
    dec = np.exp(-np.maximum(t - a, 0) / max(d, 1e-4) * curve / 3)
    return at * dec


def adsr(n, a, d, s, r):
    t = np.arange(n) / SR
    total = n / SR
    out = np.where(t < a, t / max(a, 1e-4), np.where(t < a + d, 1 - (1 - s) * (t - a) / max(d, 1e-4), s))
    rel = np.clip((total - t) / max(r, 1e-4), 0, 1)
    return out * rel


def osc(freq, dur, kind="sine", phase0=0.0):
    n = int(dur * SR)
    f = np.broadcast_to(np.asarray(freq, dtype=np.float64), (n,)) if np.ndim(freq) else np.full(n, float(freq))
    ph = 2 * np.pi * np.cumsum(f) / SR + phase0
    if kind == "sine":
        return np.sin(ph)
    if kind == "saw":
        return 2 * ((ph / (2 * np.pi)) % 1) - 1
    if kind == "square":
        return np.sign(np.sin(ph))
    if kind == "tri":
        return 2 * np.abs(2 * ((ph / (2 * np.pi)) % 1) - 1) - 1
    raise ValueError(kind)


def sweep(f0, f1, dur, shape=1.0):
    n = int(dur * SR)
    k = (np.arange(n) / max(n - 1, 1)) ** shape
    return f0 * (f1 / f0) ** k


def noise(dur, rng):
    return rng.uniform(-1, 1, int(dur * SR))


def fft_filter(x, lo=None, hi=None):
    """Brick-ish band filter with soft edges; fine for sound design."""
    n = len(x)
    if n == 0:
        return x
    X = np.fft.rfft(x)
    f = np.fft.rfftfreq(n, 1 / SR)
    g = np.ones_like(f)
    if lo:
        g *= 1 / (1 + (lo / np.maximum(f, 1)) ** 4)
    if hi:
        g *= 1 / (1 + (f / hi) ** 4)
    return np.fft.irfft(X * g, n)


def lowpass_sweep(x, f0, f1):
    """One-pole low-pass whose cutoff moves from f0 to f1."""
    out = np.empty_like(x)
    k = np.arange(len(x)) / max(len(x) - 1, 1)
    cut = max(f0, 20) * (max(f1, 20) / max(f0, 20)) ** k
    a = 1 - np.exp(-2 * np.pi * cut / SR)
    y = 0.0
    for i in range(len(x)):
        y += a[i] * (x[i] - y)
        out[i] = y
    return out


def reverb(x, rng, size=1.2, mix=0.3, damp=4000):
    ir_n = int(size * SR)
    ir = rng.normal(0, 1, ir_n) * np.exp(-np.arange(ir_n) / (SR * size / 5))
    ir = fft_filter(ir, hi=damp)
    ir /= np.sqrt(np.sum(ir ** 2)) + 1e-9
    n = len(x) + ir_n
    wet = np.fft.irfft(np.fft.rfft(x, n) * np.fft.rfft(ir, n), n)
    dry = np.concatenate([x, np.zeros(ir_n)])
    return dry * (1 - mix) + wet * mix


def dist(x, drive=3.0):
    return np.tanh(x * drive) / np.tanh(drive)


def pad(a, n):
    return np.concatenate([a, np.zeros(max(0, n - len(a)))])[:n] if len(a) < n else a[:n]


def mix(*parts):
    n = max(len(p) for p in parts)
    out = np.zeros(n)
    for p in parts:
        out[:len(p)] += p
    return out


def at(sig, offset, total=None):
    pre = np.zeros(int(offset * SR))
    s = np.concatenate([pre, sig])
    return pad(s, int(total * SR)) if total else s


def normalize(x, peak=0.9):
    m = np.max(np.abs(x)) + 1e-9
    return x / m * peak


def fade(x, fin=0.003, fout=0.03):
    n = len(x)
    a, b = int(fin * SR), int(fout * SR)
    if a:
        x[:a] *= np.linspace(0, 1, a)
    if b:
        x[-b:] *= np.linspace(1, 0, b)
    return x


# ---- building blocks

def boom(rng, dur=1.2, f0=90, f1=30, drive=2.5):
    body = osc(sweep(f0, f1, dur, 0.5), dur) * env(int(dur * SR), 0.002, dur * 0.35)
    crack = fft_filter(noise(dur, rng), 80, 2500) * env(int(dur * SR), 0.001, 0.12)
    return dist(body * 0.9 + crack * 0.6, drive)


def whoosh(rng, dur=0.5, lo=300, hi=4000, up=True):
    n = noise(dur, rng)
    f = np.linspace(0, 1, int(dur * SR))
    env_ = np.sin(np.pi * f) ** 1.5
    a, b = (lo, hi) if up else (hi, lo)
    return lowpass_sweep(n, a, b) * env_ * 1.6


def crackle(rng, dur, density=60, bright=6000):
    n = int(dur * SR)
    out = np.zeros(n)
    for _ in range(int(density * dur)):
        p = int(rng.integers(0, max(n - 400, 1)))
        ln = int(rng.integers(40, 400))
        out[p:p + ln] += rng.uniform(-1, 1, ln) * np.exp(-np.arange(ln) / (ln / 4)) * rng.uniform(0.3, 1)
    return fft_filter(out, 800, bright)


def bell(freq, dur, rng, bright=1.0):
    n = int(dur * SR)
    parts = [(1, 1), (2.76, 0.5 * bright), (5.4, 0.25 * bright), (8.93, 0.12 * bright)]
    out = np.zeros(n)
    for ratio, amp in parts:
        out += osc(freq * ratio * (1 + rng.normal(0, 0.001)), dur) * amp * env(n, 0.002, dur / ratio ** 0.5)
    return out


def chord(freqs, dur, kind="saw", rng=None, a=0.3, r=0.6, detune=0.004):
    n = int(dur * SR)
    out = np.zeros(n)
    for f in freqs:
        for d in (-detune, 0, detune):
            out += osc(f * (1 + d), dur, kind)
    return out * adsr(n, a, 0.2, 0.8, r) / (len(freqs) * 3)


def roar(rng, dur=1.4, f0=110, f1=70, formant=(500, 1400)):
    n = int(dur * SR)
    vib = 1 + 0.03 * np.sin(2 * np.pi * 7 * t_axis(dur))
    src = osc(sweep(f0, f1, dur) * vib, dur, "saw") + 0.4 * noise(dur, rng)
    voiced = sum(fft_filter(src, f * 0.7, f * 1.3) for f in formant)
    return dist(voiced * adsr(n, 0.08, 0.3, 0.7, 0.4), 4)


def zap(rng, dur=0.35, f0=2400, f1=200):
    n = int(dur * SR)
    s = osc(sweep(f0, f1, dur, 0.3), dur, "square") * 0.5
    s += noise(dur, rng) * 0.5 * (rng.uniform(0, 1, n) > 0.6)
    return fft_filter(s, 200, 9000) * env(n, 0.001, dur * 0.5)


def thunder(rng, dur=2.4):
    n = int(dur * SR)
    snap = fft_filter(noise(0.15, rng), 1500, 12000) * env(int(0.15 * SR), 0.0005, 0.05)
    rumble = lowpass_sweep(noise(dur, rng), 900, 60) * env(n, 0.02, dur * 0.6) * 2.2
    return dist(mix(snap * 1.2, rumble, crackle(rng, dur * 0.6, 120) * 0.5), 2)


def glass(rng, dur=0.8, base=1800):
    out = np.zeros(int(dur * SR))
    for k in range(9):
        f = base * rng.uniform(0.8, 2.6)
        start = rng.uniform(0, dur * 0.25)
        b = bell(f, dur - start, rng, 0.6) * rng.uniform(0.3, 1)
        out += at(b, start, dur)
    out += fft_filter(noise(dur, rng), 3000, 14000) * env(len(out), 0.001, 0.08) * 0.8
    return out


def fire(rng, dur=1.0):
    n = int(dur * SR)
    roar_ = fft_filter(noise(dur, rng), 60, 900) * 1.8
    return (roar_ + crackle(rng, dur, 90, 7000) * 0.7) * adsr(n, 0.05, 0.1, 0.8, dur * 0.4)


def wet(rng, dur=0.5):
    n = int(dur * SR)
    out = np.zeros(n)
    for k in range(5):
        st = rng.uniform(0, dur * 0.6)
        ln = rng.uniform(0.05, 0.15)
        b = osc(sweep(rng.uniform(300, 700), rng.uniform(80, 160), ln), ln) * env(int(ln * SR), 0.003, ln * 0.6)
        out += at(b, st, dur)
    out += fft_filter(noise(dur, rng), 200, 1500) * env(n, 0.005, 0.2) * 0.5
    return out


def bubbles(rng, dur=1.0, rate=18):
    out = np.zeros(int(dur * SR))
    for _ in range(int(rate * dur)):
        st = rng.uniform(0, dur * 0.9)
        ln = rng.uniform(0.03, 0.09)
        f0 = rng.uniform(200, 900)
        b = osc(sweep(f0, f0 * 1.8, ln), ln) * env(int(ln * SR), 0.002, ln * 0.5)
        out += at(b, st, dur) * rng.uniform(0.3, 1)
    return out


def drone(freq, dur, rng, rough=0.3):
    n = int(dur * SR)
    s = osc(freq, dur, "saw") + osc(freq * 1.006, dur, "saw") + osc(freq / 2, dur) * 1.5
    s = fft_filter(s, 20, 600) + fft_filter(noise(dur, rng), 40, 300) * rough
    return s * adsr(n, dur * 0.3, 0.1, 0.9, dur * 0.4)


def reverse(x):
    return x[::-1].copy()


def heartbeat(rng, beats=2, gap=0.2):
    one = boom(rng, 0.25, 70, 40, 1.5)
    return mix(one, at(one * 0.7, gap))


def note(semi, base=220.0):
    return base * 2 ** (semi / 12)


# ---- sound recipes

def rec_rage(name, rng):
    if name == "rage_slam":
        return reverb(mix(boom(rng, 1.3, 110, 28, 3), crackle(rng, 0.6, 80) * 0.6), rng, 1.0, 0.25)
    if name == "rage_leap":
        return mix(whoosh(rng, 0.45, 300, 3000), roar(rng, 0.5, 160, 120) * 0.4)
    if name == "rage_warcry":
        return reverb(roar(rng, 1.4, 140, 90, (600, 1200, 2400)), rng, 1.4, 0.35)
    if name == "rage_bloodlust":
        return mix(heartbeat(rng), at(roar(rng, 0.7, 180, 120) * 0.5, 0.35))
    if name == "rage_berserk":
        return reverb(mix(roar(rng, 1.6, 90, 60), boom(rng, 1.0, 70, 30) * 0.8, at(heartbeat(rng), 0.2)), rng, 1.6, 0.3)
    if name == "rage_rampage":
        return mix(*[at(boom(rng, 0.35, 80, 40, 3) * 0.8, i * 0.18) for i in range(5)], roar(rng, 1.2, 120, 80) * 0.5)


def rec_speed(name, rng):
    if name == "speed_dash":
        return mix(whoosh(rng, 0.3, 600, 9000), osc(sweep(800, 2600, 0.3), 0.3) * env(int(0.3 * SR), 0.01, 0.15) * 0.2)
    if name == "speed_afterimage":
        s = whoosh(rng, 0.35, 2000, 600, up=False)
        return reverb(mix(s, at(s * 0.5, 0.08), at(s * 0.25, 0.16)), rng, 0.8, 0.3)
    if name == "speed_momentum":
        return mix(*[at(bell(note(s, 880), 0.25, rng, 0.3) * 0.5, i * 0.06) for i, s in enumerate((0, 4, 7, 12))])
    if name == "speed_slipstream":
        return reverb(whoosh(rng, 1.0, 400, 6000) + osc(sweep(300, 1200, 1.0), 1.0, "tri") * adsr(int(SR), 0.1, 0.2, 0.5, 0.4) * 0.15, rng, 1.0, 0.3)
    if name == "speed_rewind":
        tick = lambda: fft_filter(noise(0.02, rng), 2000, 9000) * env(int(0.02 * SR), 0.0005, 0.008)
        ticks = mix(*[at(tick() * 0.8, i * 0.07) for i in range(10)])
        return mix(reverse(reverb(bell(660, 0.9, rng), rng, 0.8, 0.5)), ticks)
    if name == "speed_timefracture":
        g = glass(rng, 1.2, 1400)
        return reverb(mix(g, reverse(whoosh(rng, 0.6, 300, 5000)), at(boom(rng, 0.8, 120, 50) * 0.5, 0.55)), rng, 1.8, 0.4)


def rec_infernal(name, rng):
    if name == "infernal_burst":
        return mix(boom(rng, 0.9, 120, 40), fire(rng, 0.9) * 0.6)
    if name == "infernal_volley":
        return mix(*[at(mix(whoosh(rng, 0.25, 200, 2500), fire(rng, 0.25) * 0.4) * 0.8, i * 0.09) for i in range(3)])
    if name == "infernal_flamewall":
        return reverb(mix(fire(rng, 1.5) * 1.2, whoosh(rng, 0.6, 100, 2000) * 0.6), rng, 1.0, 0.2)
    if name == "infernal_meteor":
        fall = whoosh(rng, 0.9, 3000, 200, up=False)
        return mix(fall, at(boom(rng, 1.4, 100, 25, 3), 0.8), at(crackle(rng, 1.0, 80), 0.85) * 0.5)
    if name == "infernal_eruption":
        return reverb(mix(boom(rng, 1.8, 70, 20, 3), at(fire(rng, 1.6), 0.1), at(crackle(rng, 1.6, 140) * 0.6, 0.1)), rng, 1.5, 0.25)
    if name == "infernal_avatar":
        return reverb(mix(fire(rng, 2.0) * 0.9, drone(55, 2.0, rng) * 0.6, at(roar(rng, 1.0, 100, 70) * 0.5, 0.4)), rng, 1.8, 0.3)
    if name == "infernal_phoenix":
        cry = osc(sweep(1400, 2200, 0.6, 0.5) * (1 + 0.04 * np.sin(2 * np.pi * 9 * t_axis(0.6))), 0.6, "saw")
        cry = fft_filter(cry, 600, 5000) * adsr(int(0.6 * SR), 0.05, 0.1, 0.7, 0.3) * 0.5
        return reverb(mix(fire(rng, 1.2), cry, at(cry * 0.4, 0.25)), rng, 1.6, 0.35)
    if name == "infernal_rumble":
        return lowpass_sweep(noise(1.4, rng), 300, 80) * adsr(int(1.4 * SR), 0.3, 0.2, 0.8, 0.5) * 3 + crackle(rng, 1.4, 30) * 0.3


def rec_void(name, rng):
    if name == "void_step":
        return mix(reverse(whoosh(rng, 0.3, 500, 5000)), at(osc(sweep(900, 120, 0.3), 0.3) * env(int(0.3 * SR), 0.001, 0.15) * 0.5, 0.25))
    if name == "void_orb":
        hum = osc(sweep(80, 160, 0.9), 0.9) * 0.6 + osc(sweep(161, 322, 0.9), 0.9) * 0.3
        return reverb(mix(hum * adsr(int(0.9 * SR), 0.05, 0.2, 0.7, 0.3), reverse(whoosh(rng, 0.5)) * 0.3), rng, 1.4, 0.4)
    if name == "void_rift":
        tear = fft_filter(noise(0.8, rng), 100, 3000) * np.sin(np.linspace(0, np.pi, int(0.8 * SR))) ** 0.5
        return reverb(mix(tear, drone(45, 0.9, rng) * 0.5), rng, 1.6, 0.45)
    if name == "void_displace":
        s = osc(sweep(1200, 80, 0.4, 0.4), 0.4) * env(int(0.4 * SR), 0.001, 0.3)
        return reverb(mix(s, at(reverse(s) * 0.6, 0.2)), rng, 1.0, 0.4)
    if name == "void_collapse":
        return reverb(mix(reverse(reverb(boom(rng, 1.0, 120, 40), rng, 1.0, 0.6))[:int(1.4 * SR)], at(boom(rng, 1.0, 60, 25, 3), 1.3)), rng, 1.2, 0.3)
    if name == "void_singularity":
        d = drone(36, 3.0, rng, 0.6)
        suck = reverse(whoosh(rng, 2.0, 200, 6000)) * 0.7
        return reverb(mix(d, suck, at(boom(rng, 1.2, 70, 20, 3), 2.0)), rng, 2.0, 0.4)


def rec_frozen(name, rng):
    if name == "frozen_shard":
        return mix(whoosh(rng, 0.25, 2000, 10000) * 0.6, at(glass(rng, 0.4, 2600) * 0.7, 0.18))
    if name == "frozen_nova":
        return reverb(mix(glass(rng, 1.2, 1600), whoosh(rng, 0.8, 800, 8000) * 0.6, boom(rng, 0.6, 90, 50) * 0.4), rng, 1.6, 0.35)
    if name == "frozen_wall":
        crunch = crackle(rng, 0.8, 220, 9000) * 1.2
        return reverb(mix(crunch, boom(rng, 0.8, 80, 40) * 0.6, glass(rng, 0.8, 1200) * 0.4), rng, 1.0, 0.25)
    if name == "frozen_blizzard":
        wind = lowpass_sweep(noise(2.6, rng), 400, 1800) * adsr(int(2.6 * SR), 0.6, 0.3, 0.8, 0.8) * 1.8
        whistle = osc(900 + 200 * np.sin(2 * np.pi * 0.7 * t_axis(2.6)), 2.6) * adsr(int(2.6 * SR), 0.8, 0.2, 0.6, 0.8) * 0.08
        return reverb(wind + whistle, rng, 1.6, 0.3)
    if name == "frozen_shatter":
        return reverb(mix(glass(rng, 1.0, 2000) * 1.2, crackle(rng, 0.5, 300, 12000) * 0.8), rng, 1.0, 0.3)


def rec_storm(name, rng):
    if name == "storm_strike":
        return reverb(mix(zap(rng, 0.25, 6000, 1500) * 0.8, thunder(rng, 1.6)), rng, 1.4, 0.3)
    if name == "storm_chain":
        return mix(*[at(zap(rng, 0.22, 4000 - i * 500, 300) * (1 - i * 0.15), i * 0.1) for i in range(4)])
    if name == "storm_gale":
        return reverb(whoosh(rng, 0.9, 200, 5000) * 1.3, rng, 1.0, 0.3)
    if name == "storm_thunder":
        return reverb(thunder(rng, 2.8), rng, 2.0, 0.35)
    if name == "storm_tempest":
        wind = lowpass_sweep(noise(3.0, rng), 300, 2000) * adsr(int(3 * SR), 0.5, 0.3, 0.8, 0.8) * 1.4
        return reverb(mix(wind, at(thunder(rng, 2.0) * 0.8, 0.6), at(zap(rng) * 0.5, 0.3)), rng, 2.0, 0.3)


def rec_blood(name, rng):
    if name == "blood_spike":
        return mix(wet(rng, 0.4), fft_filter(noise(0.1, rng), 1500, 8000) * env(int(0.1 * SR), 0.001, 0.03))
    if name == "blood_siphon":
        s = reverse(whoosh(rng, 0.8, 300, 2500)) * 0.7
        return reverb(mix(s, wet(rng, 0.8) * 0.6, at(heartbeat(rng) * 0.6, 0.5)), rng, 1.0, 0.3)
    if name == "blood_drink":
        return mix(*[at(wet(rng, 0.25) * 0.8, i * 0.2) for i in range(3)])
    if name == "blood_pact":
        dark = chord([note(-12, 110), note(-9, 110), note(-5, 110)], 1.6, "saw", rng, 0.4, 0.8)
        return reverb(mix(fft_filter(dark, 50, 1200) * 1.2, heartbeat(rng), at(heartbeat(rng), 0.8)), rng, 1.8, 0.35)
    if name == "blood_moon":
        return reverb(mix(drone(55, 3.0, rng) * 0.8, chord([note(0, 220), note(3, 220), note(7, 220), note(10, 220)], 3.0, "tri", rng, 1.0, 1.5) * 0.6, *[at(heartbeat(rng) * 0.6, i * 0.9) for i in range(3)]), rng, 2.4, 0.4)


def rec_titan(name, rng):
    if name == "titan_slam":
        return reverb(mix(boom(rng, 1.5, 80, 22, 3.5), crackle(rng, 0.8, 160, 4000) * 0.8), rng, 1.2, 0.25)
    if name == "titan_quake":
        r = lowpass_sweep(noise(2.0, rng), 200, 60) * adsr(int(2 * SR), 0.05, 0.2, 0.8, 0.8) * 3
        return reverb(mix(r, boom(rng, 1.4, 60, 20, 3), crackle(rng, 2.0, 70, 3000) * 0.6), rng, 1.6, 0.25)
    if name == "titan_boulder":
        grind = fft_filter(noise(0.6, rng), 80, 1500) * adsr(int(0.6 * SR), 0.05, 0.1, 0.8, 0.2)
        return mix(grind, at(whoosh(rng, 0.5, 200, 1500), 0.4))
    if name == "titan_stoneskin":
        return reverb(mix(crackle(rng, 0.9, 250, 5000), boom(rng, 0.6, 140, 80) * 0.5, bell(150, 0.9, rng, 0.3) * 0.4), rng, 1.0, 0.3)
    if name == "titan_colossus":
        steps = mix(*[at(boom(rng, 0.7, 60, 28, 2.5), i * 0.55) for i in range(3)])
        return reverb(mix(steps, drone(41, 2.2, rng) * 0.4), rng, 2.0, 0.3)


def rec_celestial(name, rng):
    if name == "celestial_chime":
        return reverb(mix(*[at(bell(note(s, 880), 1.0, rng) * 0.5, i * 0.07) for i, s in enumerate((0, 7, 12))]), rng, 1.6, 0.45)
    if name == "celestial_beam":
        hum = osc(880, 1.0) * 0.3 + osc(1320, 1.0) * 0.2 + osc(1760.6, 1.0) * 0.15
        return reverb(mix(hum * adsr(int(SR), 0.03, 0.2, 0.7, 0.4), whoosh(rng, 0.4, 2000, 10000) * 0.4), rng, 1.4, 0.4)
    if name == "celestial_starfall":
        return reverb(mix(*[at(mix(whoosh(rng, 0.4, 6000, 1500, up=False) * 0.4, bell(note(rng.integers(0, 12) * 1.0, 1320), 0.6, rng) * 0.4), i * 0.12) for i in range(6)]), rng, 1.6, 0.4)
    if name == "celestial_comet":
        return mix(whoosh(rng, 0.8, 8000, 800, up=False), at(bell(660, 1.0, rng) * 0.6, 0.7), at(boom(rng, 0.6, 140, 60) * 0.4, 0.7))
    if name == "celestial_sanctuary":
        return reverb(chord([note(0, 440), note(4, 440), note(7, 440), note(12, 440)], 2.0, "tri", rng, 0.4, 1.2) * 1.2, rng, 2.2, 0.5)
    if name == "celestial_nova":
        return reverb(mix(bell(523, 1.6, rng) * 0.6, bell(784, 1.6, rng) * 0.5, whoosh(rng, 0.8, 1000, 12000) * 0.7, boom(rng, 0.8, 120, 60) * 0.3), rng, 2.0, 0.45)
    if name == "celestial_supernova":
        swell = reverse(reverb(bell(440, 1.5, rng), rng, 1.5, 0.7))[:int(1.6 * SR)]
        return reverb(mix(swell, at(boom(rng, 1.6, 90, 25, 3) * 0.8, 1.5), at(chord([note(0, 330), note(7, 330), note(16, 330)], 2.0, "saw", rng, 0.02, 1.4) * 0.5, 1.5)), rng, 2.4, 0.4)
    if name == "celestial_ascension":
        arp = mix(*[at(bell(note(s, 440), 1.0, rng) * 0.4, i * 0.12) for i, s in enumerate((0, 4, 7, 12, 16, 19, 24))])
        return reverb(mix(arp, chord([note(0, 220), note(7, 220), note(12, 220)], 2.2, "tri", rng, 0.6, 1.0) * 0.6), rng, 2.4, 0.5)


def rec_corruption(name, rng):
    if name == "corruption_bolt":
        return mix(whoosh(rng, 0.3, 300, 2500) * 0.6, at(wet(rng, 0.3), 0.2))
    if name == "corruption_spread":
        return reverb(mix(bubbles(rng, 1.0, 25), fft_filter(noise(1.0, rng), 100, 600) * adsr(int(SR), 0.2, 0.2, 0.6, 0.4) * 0.5), rng, 1.0, 0.3)
    if name == "corruption_infest":
        skitter = mix(*[at(fft_filter(noise(0.015, rng), 2000, 8000) * env(int(0.015 * SR), 0.001, 0.005), rng.uniform(0, 1.0)) for _ in range(40)])
        return mix(skitter * 0.8, bubbles(rng, 1.0, 10) * 0.6)
    if name == "corruption_rot":
        return reverb(mix(drone(65, 1.6, rng, 0.8) * 0.6, bubbles(rng, 1.6, 14) * 0.5), rng, 1.2, 0.3)
    if name == "corruption_burst":
        return mix(boom(rng, 0.7, 100, 50, 2), wet(rng, 0.6), bubbles(rng, 0.7, 30) * 0.5)
    if name == "corruption_pandemic":
        choir = chord([note(0, 110), note(1, 110), note(6, 110)], 2.6, "saw", rng, 0.8, 1.0)
        return reverb(mix(fft_filter(choir, 80, 1500) * 1.4, bubbles(rng, 2.6, 20) * 0.5, at(boom(rng, 1.0, 70, 30) * 0.6, 1.4)), rng, 2.2, 0.4)


def rec_core(name, rng):
    if name == "heart_acquire":
        return reverb(mix(heartbeat(rng) * 0.6, *[at(bell(note(s, 523), 0.9, rng) * 0.4, 0.15 + i * 0.09) for i, s in enumerate((0, 4, 7, 12))]), rng, 1.6, 0.4)
    if name == "heart_drop":
        return reverb(mix(heartbeat(rng), at(bell(330, 1.0, rng) * 0.4, 0.1)), rng, 1.2, 0.35)
    if name == "heart_awaken":
        swell = reverse(reverb(chord([note(0, 220), note(7, 220), note(12, 220)], 1.0, "saw", rng, 0.01, 0.6), rng, 1.5, 0.8))[:int(1.8 * SR)]
        hit = chord([note(0, 220), note(4, 220), note(7, 220), note(12, 220), note(16, 220)], 3.0, "saw", rng, 0.01, 2.0)
        return reverb(mix(swell * 0.8, at(fft_filter(hit, 60, 4000) * 1.2, 1.7), at(boom(rng, 1.8, 70, 25, 2.5) * 0.7, 1.7), at(bell(880, 2.5, rng) * 0.4, 1.75)), rng, 2.6, 0.4)
    if name == "mastery_milestone":
        return reverb(mix(*[at(bell(note(s, 659), 0.8, rng) * 0.45, i * 0.1) for i, s in enumerate((0, 5, 9))]), rng, 1.2, 0.35)
    if name == "skill_unlock":
        return reverb(mix(bell(784, 0.9, rng) * 0.5, at(bell(1175, 0.9, rng) * 0.4, 0.08), whoosh(rng, 0.3, 2000, 9000) * 0.3), rng, 1.2, 0.4)
    if name == "trial_intro":
        d = drone(55, 5.0, rng, 0.5)
        hits = mix(*[at(boom(rng, 1.5, 70, 25, 2.5) * 0.7, t) for t in (0.4, 2.2, 4.0)])
        return reverb(mix(d, hits, at(reverse(whoosh(rng, 1.4, 200, 4000)) * 0.6, 3.5)), rng, 2.5, 0.35)
    if name == "trial_wave":
        horn = fft_filter(osc(110 * (1 + 0.006 * np.sin(2 * np.pi * 5 * t_axis(1.6))), 1.6, "saw") + osc(165.5, 1.6, "saw") * 0.6, 60, 1400)
        return reverb(mix(horn * adsr(int(1.6 * SR), 0.15, 0.2, 0.8, 0.5), boom(rng, 0.9, 80, 35) * 0.6), rng, 1.8, 0.35)
    if name == "trial_telegraph":
        b = osc(1320, 0.12, "square") * env(int(0.12 * SR), 0.002, 0.08) * 0.25
        return mix(b, at(b, 0.16), at(osc(sweep(400, 1600, 0.5), 0.5, "tri") * adsr(int(0.5 * SR), 0.05, 0.1, 0.6, 0.15) * 0.25, 0.3))
    if name == "trial_victory":
        fan = mix(*[at(chord([note(s, 262), note(s + 4, 262), note(s + 7, 262)], 0.6 if i < 2 else 2.5, "saw", rng, 0.02, 0.3 if i < 2 else 1.5), t)
                    for i, (s, t) in enumerate(((0, 0), (5, 0.35), (7, 0.7)))])
        return reverb(mix(fft_filter(fan, 60, 5000) * 1.3, at(bell(1046, 2.0, rng) * 0.3, 0.7)), rng, 2.2, 0.35)
    if name == "trial_fail":
        desc = mix(*[at(chord([note(s, 196), note(s + 3, 196)], 0.8, "saw", rng, 0.05, 0.6) , i * 0.45) for i, s in enumerate((0, -2, -5))])
        return reverb(mix(fft_filter(desc, 50, 2000) * 1.4, at(boom(rng, 1.4, 60, 25), 0.9) * 0.6), rng, 2.0, 0.4)
    if name == "boss_roar":
        return reverb(mix(roar(rng, 2.2, 80, 45, (400, 900, 2200)), boom(rng, 1.5, 60, 25, 2) * 0.6), rng, 2.0, 0.35)
    if name == "boss_phase":
        return reverb(mix(reverse(whoosh(rng, 1.0, 200, 5000)), at(boom(rng, 1.4, 90, 25, 3), 0.95), at(roar(rng, 1.0, 120, 70) * 0.6, 1.0)), rng, 2.0, 0.35)


def rec_eye(name, rng):
    if name == "eye_open":
        wetopen = fft_filter(noise(0.6, rng), 100, 1200) * adsr(int(0.6 * SR), 0.2, 0.1, 0.5, 0.3) * 0.6
        return reverb(mix(drone(32, 3.0, rng, 0.8), at(wetopen, 0.3), at(boom(rng, 1.4, 50, 22, 2), 1.2), at(heartbeat(rng), 2.0)), rng, 2.5, 0.45)
    if name == "eye_close":
        return reverb(mix(reverse(drone(32, 2.0, rng, 0.8)), at(boom(rng, 0.9, 60, 25), 1.6) * 0.6), rng, 2.0, 0.4)
    if name == "eye_ambient":
        d = drone(27.5, 6.0, rng, 1.0) * 0.8
        whisp = fft_filter(noise(6.0, rng), 1200, 5000) * (0.5 + 0.5 * np.sin(2 * np.pi * 0.4 * t_axis(6.0))) * 0.12
        return reverb(mix(d, whisp, at(heartbeat(rng) * 0.5, 2.5)), rng, 3.0, 0.5)
    if name == "eye_speak":
        return reverb(mix(drone(41, 1.3, rng, 0.6) * 0.6, roar(rng, 1.0, 60, 50, (300, 700)) * 0.25), rng, 2.0, 0.5)
    if name == "eye_whisper":
        n = noise(1.6, rng)
        syl = (np.sin(2 * np.pi * 3.2 * t_axis(1.6)) > 0.1).astype(float)
        syl = np.convolve(syl, np.ones(800) / 800, "same")
        voice = sum(fft_filter(n, f * 0.8, f * 1.2) for f in (900, 2300, 3600)) * syl
        return reverb(voice * adsr(len(n), 0.1, 0.1, 0.9, 0.3), rng, 2.4, 0.55)
    if name == "eye_gaze":
        stab = fft_filter(chord([note(0, 110), note(1, 110), note(6, 110)], 1.4, "saw", rng, 0.005, 1.0), 40, 3000)
        return reverb(mix(stab * 1.3, boom(rng, 1.0, 80, 30) * 0.6, at(heartbeat(rng) * 0.7, 0.5)), rng, 2.2, 0.4)


SOUNDS = {}
for _prefix, _fn, _names in [
    ("rage", rec_rage, ["rage_slam", "rage_leap", "rage_warcry", "rage_bloodlust", "rage_berserk", "rage_rampage"]),
    ("speed", rec_speed, ["speed_dash", "speed_afterimage", "speed_momentum", "speed_slipstream", "speed_rewind", "speed_timefracture"]),
    ("infernal", rec_infernal, ["infernal_burst", "infernal_volley", "infernal_flamewall", "infernal_meteor", "infernal_eruption", "infernal_avatar", "infernal_phoenix", "infernal_rumble"]),
    ("void", rec_void, ["void_step", "void_orb", "void_rift", "void_displace", "void_collapse", "void_singularity"]),
    ("frozen", rec_frozen, ["frozen_shard", "frozen_nova", "frozen_wall", "frozen_blizzard", "frozen_shatter"]),
    ("storm", rec_storm, ["storm_strike", "storm_chain", "storm_gale", "storm_thunder", "storm_tempest"]),
    ("blood", rec_blood, ["blood_spike", "blood_siphon", "blood_drink", "blood_pact", "blood_moon"]),
    ("titan", rec_titan, ["titan_slam", "titan_quake", "titan_boulder", "titan_stoneskin", "titan_colossus"]),
    ("celestial", rec_celestial, ["celestial_chime", "celestial_beam", "celestial_starfall", "celestial_comet", "celestial_sanctuary", "celestial_nova", "celestial_supernova", "celestial_ascension"]),
    ("corruption", rec_corruption, ["corruption_bolt", "corruption_spread", "corruption_infest", "corruption_rot", "corruption_burst", "corruption_pandemic"]),
    ("core", rec_core, ["heart_acquire", "heart_drop", "heart_awaken", "mastery_milestone", "skill_unlock", "trial_intro", "trial_wave", "trial_telegraph", "trial_victory", "trial_fail", "boss_roar", "boss_phase"]),
    ("eye", rec_eye, ["eye_open", "eye_close", "eye_ambient", "eye_speak", "eye_whisper", "eye_gaze"]),
]:
    for _n in _names:
        SOUNDS[_n] = _fn

SUBTITLES = {
    "heart_acquire": "Chaos Heart claimed", "heart_drop": "Chaos Heart dropped", "heart_awaken": "A heart awakens",
    "mastery_milestone": "Mastery rises", "skill_unlock": "Skill unlocked", "trial_intro": "The trial begins",
    "trial_wave": "A wave approaches", "trial_telegraph": "Danger!", "trial_victory": "Trial conquered",
    "trial_fail": "Trial failed", "boss_roar": "Guardian roars", "boss_phase": "Guardian grows enraged",
    "eye_open": "The Eye opens", "eye_close": "The Eye closes", "eye_ambient": "Something watches",
    "eye_speak": "The Eye speaks", "eye_whisper": "Something whispers", "eye_gaze": "The Eye stares at you",
}


# ---- music

SCALES = {"minor": [0, 2, 3, 5, 7, 8, 10], "phrygian": [0, 1, 3, 5, 7, 8, 10], "harm": [0, 2, 3, 5, 7, 8, 11],
          "dorian": [0, 2, 3, 5, 7, 9, 10], "lydian": [0, 2, 4, 6, 7, 9, 11], "locrian": [0, 1, 3, 5, 6, 8, 10]}

# heart: (bpm, bars, root Hz, scale, lead wave, drum style, progression of scale degrees)
THEMES = {
    "rage": (150, 20, 73.42, "phrygian", "saw", "pound", [0, 0, 1, 0, 5, 0, 1, 6]),
    "speed": (180, 24, 82.41, "minor", "square", "drive", [0, 5, 3, 6, 0, 5, 3, 4]),
    "infernal": (120, 16, 65.41, "harm", "saw", "pound", [0, 5, 4, 0, 0, 1, 4, 4]),
    "void": (90, 12, 55.00, "locrian", "sine", "sparse", [0, 1, 0, 4, 0, 1, 5, 4]),
    "frozen": (105, 14, 92.50, "minor", "tri", "sparse", [0, 5, 2, 6, 0, 5, 3, 4]),
    "storm": (165, 22, 77.78, "dorian", "square", "drive", [0, 3, 6, 4, 0, 3, 5, 4]),
    "blood": (112.5, 15, 61.74, "harm", "saw", "tribal", [0, 5, 0, 4, 0, 5, 1, 4]),
    "titan": (97.5, 13, 49.00, "minor", "saw", "tribal", [0, 3, 5, 4, 0, 6, 5, 4]),
    "celestial": (120, 16, 87.31, "lydian", "tri", "sparse", [0, 1, 4, 3, 0, 1, 5, 4]),
    "corruption": (135, 18, 58.27, "phrygian", "square", "drive", [0, 1, 0, 6, 0, 1, 4, 5]),
}


def kick(rng):
    d = 0.35
    return dist(osc(sweep(150, 42, d, 0.3), d) * env(int(d * SR), 0.001, 0.18), 2)


def snare(rng):
    d = 0.25
    n = int(d * SR)
    return fft_filter(noise(d, rng), 400, 9000) * env(n, 0.001, 0.09) * 0.8 + osc(190, d) * env(n, 0.001, 0.05) * 0.5


def hat(rng, open_=False):
    d = 0.25 if open_ else 0.05
    return fft_filter(noise(d, rng), 7000, 16000) * env(int(d * SR), 0.0005, d * 0.5) * 0.5


def tom(rng, f=110):
    d = 0.4
    return osc(sweep(f, f * 0.6, d), d) * env(int(d * SR), 0.002, 0.2)


def music(kind, rng):
    bpm, bars, root, scale_name, lead_wave, drums, prog = THEMES[kind]
    beat = 60.0 / bpm
    bar = beat * 4
    total = bar * bars
    n = int(round(total * SR))
    out_bass = np.zeros(n + SR * 4)
    out_drum = np.zeros(n + SR * 4)
    out_pad = np.zeros(n + SR * 4)
    out_lead = np.zeros(n + SR * 4)
    scale = SCALES[scale_name]

    def deg(d, octave=0):
        o, i = divmod(d, 7)
        return root * 2 ** ((scale[i] + 12 * (o + octave)) / 12)

    def place(buf, sig, t):
        s = int(round(t * SR))
        e = min(len(buf), s + len(sig))
        buf[s:e] += sig[:e - s]

    k, sn, hh, oh = kick(rng), snare(rng), hat(rng), hat(rng, True)
    # the melody is a seeded walk that resolves to the chord tone on each bar line
    mel_rng = np.random.default_rng(sum(map(ord, kind)) * 31)
    motif_rhythm = [[1, 0, 0, 1, 0, 0, 1, 0], [1, 0, 1, 0, 1, 1, 0, 0], [1, 0, 0, 0, 1, 0, 1, 1], [1, 1, 0, 1, 0, 1, 0, 0]]
    rhythm = [motif_rhythm[int(mel_rng.integers(0, 4))] for _ in range(4)]
    contour = [int(x) for x in mel_rng.integers(-2, 3, 32)]
    intro_bars = 2 if bars >= 14 else 1
    for b in range(bars):
        t0 = b * bar
        d = prog[b % len(prog)]
        section = 0 if b < intro_bars else (2 if b >= bars - max(2, bars // 6) else 1)
        # pad chord: root, third, fifth from the scale
        chord_f = [deg(d, 1), deg(d + 2, 1), deg(d + 4, 1)]
        p = chord(chord_f, bar + 0.4, "saw" if kind not in ("celestial", "frozen", "void") else "tri", rng, a=0.4, r=0.5)
        place(out_pad, fft_filter(p, 80, 2200 if section else 900), t0)
        if section == 0:
            continue
        # bass ostinato on eighths
        for e in range(8):
            if kind in ("void", "celestial", "frozen") and e % 2:
                continue
            f = deg(d) * (2 if e in (3, 6) and kind in ("speed", "storm", "corruption") else 1)
            ln = beat / 2 * 0.95
            bs = osc(f, ln, "saw") * 0.6 + osc(f / 2, ln) * 0.6
            bs = fft_filter(bs, 30, 700) * adsr(int(ln * SR), 0.005, 0.05, 0.7, 0.04)
            place(out_bass, bs, t0 + e * beat / 2)
        # drums
        for st in range(16):
            t = t0 + st * beat / 4
            if drums == "pound":
                if st % 4 == 0 or st in (10,):
                    place(out_drum, k, t)
                if st in (4, 12):
                    place(out_drum, sn, t)
                if st % 2 == 0:
                    place(out_drum, hh, t)
            elif drums == "drive":
                if st % 4 == 0:
                    place(out_drum, k, t)
                if st in (4, 12):
                    place(out_drum, sn, t)
                place(out_drum, hh * (0.6 if st % 2 else 1), t)
                if st == 14:
                    place(out_drum, oh, t)
            elif drums == "tribal":
                if st in (0, 3, 8, 11):
                    place(out_drum, k, t)
                if st in (6, 14):
                    place(out_drum, tom(rng, 140), t)
                if st in (7, 15):
                    place(out_drum, tom(rng, 95), t)
                if st == 12:
                    place(out_drum, sn * 0.7, t)
            elif drums == "sparse":
                if st == 0 or (st == 10 and b % 2):
                    place(out_drum, k * 0.8, t)
                if st == 8:
                    place(out_drum, sn * 0.5, t)
                if st % 4 == 2:
                    place(out_drum, hh * 0.5, t)
        # lead melody (from the second section onward, louder near the end)
        if section >= 1 and (b - intro_bars) % 4 != 3 or section == 2:
            r = rhythm[b % 4]
            idx = d + 7
            for e, hit in enumerate(r):
                if not hit:
                    continue
                idx += contour[(b * 8 + e) % 32] if e else 0
                f = deg(idx, 1)
                ln = beat / 2 * (1.8 if e == 7 or not any(r[e + 1:e + 2]) else 0.9)
                lw = osc(f * (1 + 0.003 * np.sin(2 * np.pi * 5.5 * t_axis(ln))), ln, lead_wave)
                if lead_wave in ("saw", "square"):
                    lw = fft_filter(lw, 200, 3500)
                lw = lw * adsr(int(ln * SR), 0.01, 0.08, 0.6, 0.08)
                place(out_lead, lw * (0.9 if section == 2 else 0.7), t0 + e * beat / 2)

    lead = reverb(out_lead, rng, 1.6, 0.35)[:len(out_lead)]
    padr = reverb(out_pad, rng, 2.2, 0.4)[:len(out_pad)]
    full = normalize(out_bass, 1) * 0.55 + normalize(out_drum, 1) * 0.6 + normalize(padr, 1) * 0.35 + normalize(lead, 1) * 0.45
    # wrap everything that rings past the loop point back onto the start so the loop is seamless
    body = full[:n].copy()
    tail = full[n:]
    body[:len(tail)] += tail[:n]
    return normalize(dist(body, 1.3), 0.85)


def write_ogg(name, x, folder, quality=4):
    x = np.clip(x, -1, 1)
    pcm = (x * 32767).astype("<i2")
    os.makedirs(folder, exist_ok=True)
    dest = os.path.join(folder, name + ".ogg")
    with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as tmp:
        path = tmp.name
    try:
        with wave.open(path, "wb") as w:
            w.setnchannels(1)
            w.setsampwidth(2)
            w.setframerate(SR)
            w.writeframes(pcm.tobytes())
        subprocess.run(["ffmpeg", "-loglevel", "error", "-y", "-i", path, "-c:a", "libvorbis", "-q:a", str(quality),
                        "-map_metadata", "-1", dest], check=True)
    finally:
        os.unlink(path)


def audio():
    folder = os.path.join(PACK, "assets", "chaoshearts", "sounds")
    defs = {}
    lang = {}
    for name, fn in SOUNDS.items():
        rng = np.random.default_rng(sum(map(ord, name)) * 7919)
        x = fn(name, rng)
        if x is None:
            raise SystemExit(f"no recipe produced audio for {name}")
        x = fade(normalize(x, 0.92))
        # trim trailing silence left by reverb tails
        thr = np.nonzero(np.abs(x) > 0.004)[0]
        if len(thr):
            x = fade(x[:thr[-1] + int(0.05 * SR)])
        write_ogg(name, x, os.path.join(folder, "sfx"))
        d = {"sounds": [{"name": f"chaoshearts:sfx/{name}", "attenuation_distance": 32 if name.startswith(("boss", "eye", "trial", "heart_awaken")) else 20}]}
        sub = SUBTITLES.get(name) or name.split("_", 1)[0].capitalize() + " heart: " + name.split("_", 1)[1].replace("_", " ")
        d["subtitle"] = f"subtitles.chaoshearts.{name}"
        lang[f"subtitles.chaoshearts.{name}"] = sub
        defs[name] = d
        print("sfx", name, f"{len(x) / SR:.2f}s")
    for kind in THEMES:
        rng = np.random.default_rng(sum(map(ord, kind)) * 104729)
        x = music(kind, rng)
        write_ogg(f"trial_music_{kind}", x, os.path.join(folder, "music"), 3)
        defs[f"trial_music_{kind}"] = {"sounds": [{"name": f"chaoshearts:music/trial_music_{kind}", "stream": True, "volume": 0.8}]}
        print("music", kind, f"{len(x) / SR:.2f}s")
    write_json("assets/chaoshearts/sounds.json", defs)
    write_json("assets/chaoshearts/lang/en_us.json", lang)


def main():
    if not shutil.which("ffmpeg"):
        sys.exit("ffmpeg is needed to encode the sounds")
    if os.path.isdir(PACK):
        shutil.rmtree(PACK)
    os.makedirs(PACK)
    write_json("pack.mcmeta", {"pack": {
        "description": [{"text": "Chaos Hearts", "color": "#c04cff", "bold": True}, {"text": "\nHearts, trials, effects and sounds", "color": "gray"}],
        "pack_format": 75, "min_format": [75, 0], "max_format": [75, 0]}})
    heart_textures()
    eye_textures()
    models()
    item_definitions()
    mod_icon()
    if "--no-audio" not in sys.argv:
        audio()
    print("resource pack written to", PACK)


if __name__ == "__main__":
    main()
