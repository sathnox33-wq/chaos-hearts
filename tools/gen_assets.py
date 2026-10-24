#!/usr/bin/env python3
"""
Generates the Chaos Hearts resource pack from scratch: textures, models, item
definitions, sound definitions, synthesized sound effects and trial music.

Everything is procedural and seeded, so running it again produces the same pack.

    python3 tools/gen_assets.py              # writes ./resourcepack
    python3 tools/gen_assets.py --no-audio   # same, but keeps the already generated sounds

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
from PIL import Image, ImageDraw, ImageFilter

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PACK = os.path.join(ROOT, "resourcepack")
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


def to_image(arr):
    return Image.fromarray(np.clip(arr, 0, 255).astype(np.uint8), "RGBA")


def save_texture(path, frames, frametime=None, interpolate=True):
    full = os.path.join(PACK, "assets", "chaoshearts", "textures", path + ".png")
    os.makedirs(os.path.dirname(full), exist_ok=True)
    if len(frames) == 1:
        to_image(frames[0]).save(full)
        return
    strip = np.concatenate(frames, axis=0)
    to_image(strip).save(full)
    with open(full + ".mcmeta", "w") as f:
        json.dump({"animation": {"frametime": frametime, "interpolate": interpolate}}, f, indent=2)



# =====================================================================  drawing helpers

GLYPHS = json.load(open(os.path.join(ROOT, "tools", "glyphs.json"), encoding="utf-8"))
ABILITIES = json.load(open(os.path.join(ROOT, "tools", "hearts.json"), encoding="utf-8"))
HCOL = {k: (m, s) for k, m, s in HEARTS}


def col3(c):
    return rgb(c) if isinstance(c, (int, np.integer)) else np.asarray(c, dtype=np.float64)


def lc(c, k):
    """Lighten towards white by k (0..1)."""
    c = col3(c)
    return c + (255 - c) * k


def dk(c, k):
    """Darken towards black by k (0..1)."""
    return col3(c) * (1 - k)


def mixc(a, b, t):
    return col3(a) * (1 - t) + col3(b) * t


def blank(h, w):
    return np.zeros((h, w, 4))


def over(img, col, a):
    """Composite a colour (or HxWx3 colour field) with coverage a over a straight-alpha RGBA float image."""
    a = np.clip(np.broadcast_to(np.asarray(a, dtype=np.float64), img.shape[:2]), 0, 1)[..., None]
    col = np.broadcast_to(np.asarray(col, dtype=np.float64), img[..., :3].shape)
    da = img[..., 3:4] / 255
    oa = a + da * (1 - a)
    img[..., :3] = (col * a + img[..., :3] * da * (1 - a)) / np.maximum(oa, 1e-6)
    img[..., 3:4] = oa * 255
    return img


def over_img(dst, src):
    return over(dst, src[..., :3], src[..., 3] / 255)


def smooth(e0, e1, x):
    t = np.clip((np.asarray(x, dtype=np.float64) - e0) / (e1 - e0), 0, 1)
    return t * t * (3 - 2 * t)


def gauss(x, s):
    return np.exp(-(np.asarray(x, dtype=np.float64) / s) ** 2)


def pnoise(h, w, rng, beta=2.0, aniso=(1.0, 1.0)):
    """Periodic (tileable) fractal noise in 0..1, made by shaping white noise in the frequency domain."""
    n = rng.normal(size=(h, w))
    fy = np.fft.fftfreq(h)[:, None] * h * aniso[1]
    fx = np.fft.fftfreq(w)[None, :] * w * aniso[0]
    f = np.sqrt(fx ** 2 + fy ** 2)
    f[0, 0] = 1
    F = np.fft.fft2(n) / f ** beta
    F[0, 0] = 0
    r = np.real(np.fft.ifft2(F))
    return (r - r.min()) / (r.max() - r.min() + 1e-9)


def uv_grid(h, w):
    ys, xs = np.mgrid[0:h, 0:w].astype(np.float64)
    return (xs + 0.5) / w, (ys + 0.5) / h


def polar(h, w):
    """Centred coordinates in -1..1, radius and angle."""
    u, v = uv_grid(h, w)
    x, y = u * 2 - 1, v * 2 - 1
    return x, y, np.hypot(x, y), np.arctan2(y, x)


def ellipse_pts(cx, cy, rx, ry, rot=0.0, n=48):
    c, s = math.cos(math.radians(rot)), math.sin(math.radians(rot))
    out = []
    for k in range(n):
        a = 2 * math.pi * k / n
        x, y = rx * math.cos(a), ry * math.sin(a)
        out.append((cx + x * c - y * s, cy + x * s + y * c))
    return out


def arc_pts(cx, cy, r, a0, a1, n=28):
    return [(cx + r * math.cos(math.radians(a0 + (a1 - a0) * k / (n - 1))),
             cy + r * math.sin(math.radians(a0 + (a1 - a0) * k / (n - 1)))) for k in range(n)]


def star_pts(cx, cy, ro, ri, n, rot=-90.0):
    pts = []
    for k in range(n * 2):
        a = math.radians(rot + 180.0 * k / n)
        r = ro if k % 2 == 0 else ri
        pts.append((cx + r * math.cos(a), cy + r * math.sin(a)))
    return pts


def bez(p0, p1, p2, n=20):
    return [((1 - t) ** 2 * p0[0] + 2 * (1 - t) * t * p1[0] + t * t * p2[0],
             (1 - t) ** 2 * p0[1] + 2 * (1 - t) * t * p1[1] + t * t * p2[1]) for t in np.linspace(0, 1, n)]


def flame_pts(cx, by, w, h, lean=0.0):
    r = w / 2
    pts = arc_pts(cx, by - r, r, 0, 180, 14)
    pts += bez((cx - r, by - r), (cx - r * 0.7, by - h * 0.62), (cx + lean, by - h), 12)[1:]
    pts += bez((cx + lean, by - h), (cx + r * 1.05, by - h * 0.5), (cx + r, by - r), 12)[1:]
    return pts


def drop_pts(cx, cy, r, tip=2.3):
    pts = arc_pts(cx, cy, r, -15, 195, 18)
    return pts + [(cx, cy - r * tip)]


def heart_pts(cx, cy, s, n=40):
    out = []
    for k in range(n):
        t = 2 * math.pi * k / n
        x = 16 * math.sin(t) ** 3
        y = 13 * math.cos(t) - 5 * math.cos(2 * t) - 2 * math.cos(3 * t) - math.cos(4 * t)
        out.append((cx + x * s / 16, cy - y * s / 16))
    return out


def jag(p0, p1, n, amp, rng):
    """A jagged polyline from p0 to p1 (midpoint-ish displacement)."""
    pts = []
    dx, dy = p1[0] - p0[0], p1[1] - p0[1]
    ln = math.hypot(dx, dy) + 1e-9
    nx, ny = -dy / ln, dx / ln
    for k in range(n + 1):
        t = k / n
        o = 0 if k in (0, n) else rng.normal(0, amp)
        pts.append((p0[0] + dx * t + nx * o, p0[1] + dy * t + ny * o))
    return pts


class Art:
    """Supersampled vector drawing onto a straight-alpha RGBA float image (units are output pixels)."""

    def __init__(self, w, h=None, ss=4):
        self.w, self.h, self.ss = w, h or w, ss
        self.img = blank(self.h, self.w)

    def mask(self, draw, blur=0):
        im = Image.new("L", (self.w * self.ss, self.h * self.ss), 0)
        draw(ImageDraw.Draw(im), self.ss)
        if blur:
            im = im.filter(ImageFilter.GaussianBlur(blur * self.ss))
        if self.ss > 1:
            im = im.resize((self.w, self.h), Image.BOX)
        return np.asarray(im, dtype=np.float64) / 255

    def put(self, m, col, a=1.0):
        over(self.img, col, m * a)
        return self

    def poly(self, pts, col, a=1.0, blur=0):
        return self.put(self.mask(lambda d, s: d.polygon([(x * s, y * s) for x, y in pts], fill=255), blur), col, a)

    def line(self, pts, w, col, a=1.0, blur=0, cap=True):
        def f(d, s):
            P = [(x * s, y * s) for x, y in pts]
            d.line(P, fill=255, width=max(1, int(round(w * s))), joint="curve")
            if cap:
                r = w * s / 2
                for x, y in (P[0], P[-1]):
                    d.ellipse([x - r, y - r, x + r, y + r], fill=255)
        return self.put(self.mask(f, blur), col, a)

    def lines(self, polys, col, a=1.0, blur=0):
        """Many (pts, width) polylines in one mask."""
        def f(d, s):
            for pts, w in polys:
                P = [(x * s, y * s) for x, y in pts]
                d.line(P, fill=255, width=max(1, int(round(w * s))), joint="curve")
        return self.put(self.mask(f, blur), col, a)

    def circle(self, cx, cy, r, col, a=1.0, blur=0):
        return self.put(self.mask(lambda d, s: d.ellipse([(cx - r) * s, (cy - r) * s, (cx + r) * s, (cy + r) * s], fill=255), blur), col, a)

    def ellipse(self, cx, cy, rx, ry, col, a=1.0, blur=0, rot=0):
        return self.poly(ellipse_pts(cx, cy, rx, ry, rot), col, a, blur)

    def ring(self, cx, cy, r, w, col, a=1.0, blur=0, ry=None, rot=0):
        pts = ellipse_pts(cx, cy, r, ry or r, rot, 56)
        return self.line(pts + pts[:2], w, col, a, blur, cap=False)

    def arc(self, cx, cy, r, a0, a1, w, col, a=1.0, blur=0):
        return self.line(arc_pts(cx, cy, r, a0, a1), w, col, a, blur)

    def star(self, cx, cy, ro, ri, n, col, a=1.0, blur=0, rot=-90):
        return self.poly(star_pts(cx, cy, ro, ri, n, rot), col, a, blur)

    def rect(self, x0, y0, x1, y1, col, a=1.0, blur=0):
        return self.poly([(x0, y0), (x1, y0), (x1, y1), (x0, y1)], col, a, blur)


def outlined(sym, col=(8, 4, 12), a=0.95):
    """Puts a 1px dark outline under a sprite so it reads without the text shadow."""
    al = sym[..., 3] / 255
    dil = al.copy()
    for dy in (-1, 0, 1):
        for dx in (-1, 0, 1):
            dil = np.maximum(dil, np.roll(np.roll(al, dy, 0), dx, 1))
    out = blank(*al.shape)
    over(out, col, np.clip(dil * 1.6, 0, 1) * a)
    return over_img(out, sym)


def save_png(path, img):
    full = os.path.join(PACK, "assets", "chaoshearts", "textures", path + ".png")
    os.makedirs(os.path.dirname(full), exist_ok=True)
    to_image(img).save(full)


# =====================================================================  HUD

HUD_DIR = os.path.join(PACK, "assets", "chaoshearts", "textures", "gui", "hud")

# vanilla health heart footprint: o = outline, # = fill
H_SHAPE = [".oo...oo.",
           "o##o.o##o",
           "o###o###o",
           "o#######o",
           "o#######o",
           ".o#####o.",
           "..o###o..",
           "...o#o...",
           "....o...."]

# per-heart 9x9 emblem drawn over the shaded fill ('.' keeps the base); pixels outside the
# heart are allowed (blood drips) and are drawn in every state except empty
H_ART = {
    "rage": ([".........",
              ".lw...dk.",
              ".wl...d..",
              "....k....",
              "...k.k...",
              "..bk..d..",
              "...b.d...",
              "......b..",
              "......B.."],
             {"k": (28, 0, 2), "b": (120, 0, 8), "B": (70, 0, 4), "d": (110, 8, 10)}),
    "speed": ([".........",
               ".ww...c..",
               ".w...c...",
               "....Wc...",
               ".c..cW...",
               "....c....",
               "...c.....",
               ".........",
               "........."],
              {"c": (41, 211, 242), "W": (235, 255, 255)}),
    "infernal": ([".........",
                  ".ll...dl.",
                  ".l.k..k..",
                  "..k.yy.k.",
                  "...yYy...",
                  "..k.y.k..",
                  "...k.k...",
                  ".........",
                  "........."],
                 {"k": (70, 10, 0), "y": (255, 214, 90), "Y": (255, 252, 220), "d": (190, 50, 0)}),
    "void": ([".........",
              ".wl...ll.",
              ".l.....l.",
              "..lkkkl..",
              ".lkskkkl.",
              "..kkksk..",
              "...lkl...",
              ".........",
              "........."],
             {"k": (6, 0, 16), "s": (255, 255, 255)}),
    "frozen": ([".........",
                ".ww...lw.",
                ".wl..ldl.",
                ".lwlw.dd.",
                ".llwlldd.",
                "..lwldd..",
                "...wdd...",
                "....d....",
                "........."],
               {"w": (250, 255, 255), "l": (190, 240, 255), "d": (70, 140, 200)}),
    "storm": ([".........",
               ".gw...gg.",
               ".ggg.yg..",
               ".gggy.g..",
               "...yyy...",
               "....y....",
               "...y.....",
               ".........",
               "........."],
              {"g": (120, 140, 175), "y": (255, 245, 150)}),
    "blood": ([".........",
               ".ww...lm.",
               ".wl......",
               "....p....",
               "....p....",
               "...ppp...",
               "...ppp.b.",
               "....p..B.",
               "........."],
              {"p": (225, 40, 64), "b": (140, 8, 24), "B": (80, 0, 10)}),
    "titan": ([".........",
               ".ls...ls.",
               ".sks.ssk.",
               ".gygggyg.",
               ".sssgsss.",
               "..ssgss..",
               "...sgs...",
               "....g....",
               "........."],
              {"s": (125, 118, 105), "l": (170, 162, 148), "k": (58, 52, 45), "g": (201, 164, 92), "y": (255, 230, 150)}),
    "celestial": ([".........",
                   ".ll...ll.",
                   ".l.......",
                   "....w....",
                   "..ywWwy..",
                   "....w....",
                   "....y....",
                   ".........",
                   "........."],
                  {"W": (255, 255, 255), "w": (255, 252, 225), "y": (255, 196, 64)}),
    "corruption": ([".........",
                    ".gl...pp.",
                    ".l.v.pvp.",
                    "...v.v.p.",
                    ".pp.v..y.",
                    "..vp.v...",
                    "...pv....",
                    "....p....",
                    "........."],
                   {"p": (92, 40, 120), "v": (36, 8, 52), "y": (200, 255, 130), "g": (170, 240, 110)}),
}


def heart9(kind, state):
    main, sec = HCOL[kind]
    rows, pal = H_ART[kind]
    base_pal = {"w": lc(main, 0.75), "l": lc(main, 0.35), "m": col3(main), "d": dk(sec, 0.2)}
    base_pal.update({k: col3(v) for k, v in pal.items()})
    husk_c = mixc(dk(sec, 0.82), (16, 12, 18), 0.5)
    active = state in ("full_active", "half_active", "full_active2")
    pulse = state == "full_active2"
    half = state.startswith("half")
    empty = state == "empty"
    img = blank(9, 9)
    for y in range(9):
        for x in range(9):
            s = H_SHAPE[y][x]
            ch = rows[y][x]
            if s == "o":
                if active:
                    c = lc(main, 0.8 if pulse else 0.5)
                else:
                    c = mixc(dk(sec, 0.8), (0, 0, 0), 0.6)
                img[y, x] = [*c, 255]
            elif s == "#":
                t = ((8 - x) * 0.35 + (8 - y) * 0.65) / 8
                c = mixc(dk(main, 0.5), lc(main, 0.12), t)
                if ch != ".":
                    c = base_pal[ch]
                if empty or (half and x > 4):
                    c = mixc(husk_c * (0.85 + 0.3 * t), c, 0.12)
                elif active:
                    c = lc(c, 0.3 if pulse else 0.14)
                img[y, x] = [*np.clip(c, 0, 255), 255]
            elif ch != "." and not empty and not (half and x > 4):
                img[y, x] = [*base_pal[ch], 255]
    return img


def hud_glyph(img, ascent, height):
    """Font-ready glyph: padded below when the ascent is above the glyph (a bitmap provider may not
    have ascent > height), and with a near-invisible pixel in the last column so Minecraft does not
    trim the advance. Returns (image, font height)."""
    img = img.copy()
    pad = max(0, ascent - height)
    if pad:
        img = np.concatenate([img, blank(pad, img.shape[1])], axis=0)
    if img[:, -1, 3].max() < 1:
        img[-1, -1] = [255, 255, 255, 1]
    return img, height + pad


FONTS = {}


def font_add(font, file, ascent, height, char, img):
    """Writes a glyph texture and records its bitmap provider for font `font` (chaoshearts:<font>)."""
    g, fh = hud_glyph(img, ascent, height)
    full = os.path.join(PACK, "assets", "chaoshearts", "textures", file)
    os.makedirs(os.path.dirname(full), exist_ok=True)
    to_image(g).save(full)
    FONTS.setdefault(font, []).append({"type": "bitmap", "file": "chaoshearts:" + file, "ascent": ascent,
                                       "height": fh, "chars": [char]})


def cp(h):
    return chr(int(h, 16))


def fname(res):
    return res.split(":", 1)[1]


def hud_hearts():
    hg = GLYPHS["hearts"]
    base = int(hg["base"], 16)
    for i, (kind, _, _) in enumerate(HEARTS):
        for state, k in hg["states"].items():
            img = heart9(kind, state)
            ch = chr(base + i * 8 + k)
            path = hg["texture"].replace("<h>", kind).replace("<state>", state).split(":", 1)[1]
            for f in hg["fonts"].values():
                g, fh = hud_glyph(img, f["ascent"], hg["height"])
                FONTS.setdefault(fname(f["font"]), []).append(
                    {"type": "bitmap", "file": "chaoshearts:" + path, "ascent": f["ascent"], "height": fh, "chars": [ch]})
            full = os.path.join(PACK, "assets", "chaoshearts", "textures", path)
            os.makedirs(os.path.dirname(full), exist_ok=True)
            to_image(hud_glyph(img, 0, hg["height"])[0]).save(full)


# ---- ability icons

def icon_base(main, sec, rng):
    u, v = uv_grid(16, 16)
    r = np.hypot(u - 0.5, v - 0.42)
    t = np.clip(r * 1.7, 0, 1)[..., None]
    bg = mixc(main, (0, 0, 0), 0.62)[None, None] * (1 - t) + mixc(sec, (0, 0, 0), 0.82)[None, None] * t
    bg += rng.normal(0, 4, bg.shape)
    img = blank(16, 16)
    img[..., :3] = np.clip(bg, 0, 255)
    img[..., 3] = 255
    return img


def icon_frame(main, img, inner=True):
    edge = (12, 8, 16)
    for y in range(16):
        for x in range(16):
            o = x in (0, 15) or y in (0, 15)
            corner = (x in (0, 15) and y in (0, 15))
            if corner:
                img[y, x] = [0, 0, 0, 0]
            elif o or (x in (1, 14) and y in (1, 14)):
                img[y, x] = [*edge, 255]
            elif inner and (x in (1, 14) or y in (1, 14)):
                k = 0.25 if (y == 1 or x == 1) else 0.6
                img[y, x] = [*mixc(main, (0, 0, 0), k), 255]
    return img


def interior_mask():
    m = np.zeros((16, 16))
    m[1:15, 1:15] = 1
    for x, y in ((1, 1), (14, 1), (1, 14), (14, 14)):
        m[y, x] = 0
    return m


def draw_ability(kind, slot, A, m, s, rng):
    L, W, K = lc(m, 0.55), (255, 255, 255), (10, 4, 10)
    key = f"{kind}{slot}"
    if key == "rage1":  # Rage Leap: arcing leap that slams into the ground
        A.line([(2, 13.6), (14, 13.6)], 1.0, dk(m, 0.4))
        pts = bez((2.5, 12.5), (6.5, -2.5), (11.8, 10.5), 24)
        A.line(pts, 2.2, m, 0.45, blur=0.6).line(pts, 1.1, L)
        A.poly([(10.0, 9.0), (13.6, 9.6), (11.6, 12.6)], W)
        A.star(11.8, 12.6, 3.4, 1.0, 6, lc(m, 0.3), rot=-75).circle(11.8, 12.6, 1.0, W)
        for x, y in ((5, 12.2), (14.2, 11.0), (8.8, 11.6)):
            A.circle(x, y, 0.5, dk(m, 0.2))
    elif key == "rage2":  # War Cry: a fanged maw and sound waves
        A.circle(5.5, 8, 3.6, dk(m, 0.75)).circle(5.5, 8, 2.4, (30, 0, 0))
        A.poly([(3.8, 5.6), (4.6, 7.4), (5.4, 5.4), (6.2, 7.4), (7.0, 5.6)], W)
        A.poly([(3.8, 10.4), (4.6, 8.8), (5.4, 10.6), (6.2, 8.8), (7.0, 10.4)], W)
        for i, r in enumerate((5.4, 7.8, 10.2)):
            A.arc(5.5, 8, r, -42, 42, 1.3 - i * 0.15, lc(m, 0.5 - i * 0.12), 1 - i * 0.2)
    elif key == "rage3":  # Berserk Chain: chain links dripping blood
        steel = (190, 175, 175)
        A.ring(5.2, 5.2, 2.9, 1.3, steel, ry=1.7, rot=45)
        A.ring(10.6, 10.6, 2.9, 1.3, steel, ry=1.7, rot=45)
        A.ring(7.9, 7.9, 2.3, 1.3, lc(m, 0.25), ry=1.3, rot=-45)
        A.poly(drop_pts(12.6, 13.4, 1.2), m).poly(drop_pts(3.4, 11.8, 0.9), dk(m, 0.2))
        A.circle(7.9, 7.9, 1.2, m, 0.6, blur=0.8)
    elif key == "rage4":  # Rampage: a horned demon skull wreathed in fury
        A.circle(8, 8.5, 6.4, m, 0.5, blur=1.4)
        A.poly([(5.2, 6.4), (1.8, 4.6), (2.0, 1.4), (3.6, 4.0), (6.4, 5.0)], (230, 220, 200))
        A.poly([(10.8, 6.4), (14.2, 4.6), (14.0, 1.4), (12.4, 4.0), (9.6, 5.0)], (230, 220, 200))
        A.ellipse(8, 8.6, 4.0, 4.3, dk(m, 0.55))
        A.poly([(5.0, 7.4), (7.4, 8.4), (5.6, 9.2)], (255, 220, 80)).poly([(11.0, 7.4), (8.6, 8.4), (10.4, 9.2)], (255, 220, 80))
        A.poly([(6.0, 11.0), (6.6, 12.6), (7.2, 11.0), (8.0, 12.8), (8.8, 11.0), (9.4, 12.6), (10.0, 11.0)], W)
    elif key == "speed1":  # Dash: chevrons and streaks
        for y, x0 in ((5.5, 1.5), (8, 1.0), (10.5, 1.5)):
            A.line([(x0, y), (x0 + 3.5, y)], 0.9, lc(s, 0.3), 0.8)
        A.line([(5.6, 3.6), (9.6, 8), (5.6, 12.4)], 1.9, s)
        A.line([(9.0, 3.6), (13.0, 8), (9.0, 12.4)], 1.9, lc(m, 0.2))
    elif key == "speed2":  # Afterimage: a runner and its fading echoes
        def runner(dx, col, a):
            A.circle(9.5 + dx, 3.6, 1.4, col, a)
            A.line([(9.2 + dx, 5.2), (8.2 + dx, 9.0)], 1.5, col, a)
            A.line([(6.4 + dx, 6.4), (8.9 + dx, 6.2), (11.2 + dx, 7.8)], 1.1, col, a)
            A.line([(8.2 + dx, 9.0), (10.6 + dx, 10.6), (10.0 + dx, 13.4)], 1.2, col, a)
            A.line([(8.2 + dx, 9.0), (6.6 + dx, 11.6), (4.4 + dx, 11.8)], 1.2, col, a)
        runner(-4.2, s, 0.35)
        runner(-2.1, mixc(s, m, 0.5), 0.6)
        runner(0, lc(m, 0.3), 1.0)
    elif key == "speed3":  # Slipstream: wind ribbons
        for i, (c, ph) in enumerate(((5.0, 0.0), (8.4, 1.4), (11.8, 2.6))):
            pts = [(x, c + 1.1 * math.sin(x * 0.7 + ph)) for x in np.linspace(2, 12.5, 18)]
            A.line(pts, 1.3, lc(s, 0.25) if i != 1 else lc(m, 0.2), 1.0 - 0.15 * (i == 2))
        A.arc(12.6, 6.6, 1.6, -100, 140, 1.0, lc(s, 0.4))
        A.arc(12.6, 10.0, 1.4, -120, 120, 1.0, lc(m, 0.4))
    elif key == "speed4":  # Time Fracture: a shattered clock
        A.circle(8, 8, 5.6, dk(m, 0.65)).ring(8, 8, 5.6, 1.2, lc(m, 0.15))
        for k in range(12):
            a = math.radians(k * 30)
            A.line([(8 + 4.2 * math.cos(a), 8 + 4.2 * math.sin(a)), (8 + 4.9 * math.cos(a), 8 + 4.9 * math.sin(a))], 0.6, lc(m, 0.4))
        A.line([(8, 8), (8, 4.3)], 1.0, W).line([(8, 8), (10.8, 9.4)], 1.0, W)
        crack = [(2.4, 3.2), (5.6, 6.4), (7.2, 5.8), (9.4, 9.6), (11.0, 9.2), (13.8, 13.2)]
        A.line(crack, 1.6, s, 0.7, blur=0.5).line(crack, 0.7, (240, 255, 255))
    elif key == "infernal1":  # Fireball Volley: three blazing shots
        for cx, cy, r in ((4.4, 12.0, 1.7), (8.2, 8.0, 2.0), (12.0, 4.0, 2.2)):
            A.poly([(cx - r * 0.7, cy - r * 0.5), (cx - r * 2.6, cy + r * 2.2), (cx + r * 0.5, cy + r * 0.7)], s, 0.85)
            A.circle(cx, cy, r, m).circle(cx + 0.2, cy - 0.2, r * 0.6, (255, 220, 120)).circle(cx + 0.3, cy - 0.3, r * 0.25, W)
    elif key == "infernal2":  # Flame Wall: a line of flames over hot stone
        A.rect(1.5, 12.4, 14.5, 14.2, (60, 18, 8))
        for x in (3.0, 6.3, 9.6, 12.9):
            A.line([(x - 1.2, 13.3), (x + 1.2, 13.3)], 0.5, (255, 140, 40))
        for x, h in ((3.4, 7.8), (6.4, 10.2), (9.5, 8.8), (12.5, 10.6)):
            A.poly(flame_pts(x, 12.6, 3.3, h, 0.4), m)
            A.poly(flame_pts(x, 12.6, 1.8, h * 0.6, 0.2), (255, 220, 110))
    elif key == "infernal3":  # Magma Eruption: a volcano spewing lava
        A.poly(flame_pts(8, 7.5, 4.0, 7.0), m, 0.9).poly(flame_pts(8, 7.5, 2.2, 5.0), (255, 225, 120))
        A.poly([(0.8, 14.6), (5.8, 7.2), (10.2, 7.2), (15.2, 14.6)], (54, 26, 20))
        A.poly([(5.8, 7.2), (10.2, 7.2), (9.4, 8.2), (6.6, 8.2)], (255, 160, 40))
        A.line([(7.4, 8.0), (6.8, 10.6), (7.6, 12.4), (6.8, 14.4)], 1.0, (255, 120, 20))
        for x, y in ((3.0, 4.6), (12.8, 3.6), (13.6, 7.2), (2.4, 8.4)):
            A.circle(x, y, 0.8, (255, 170, 50))
    elif key == "infernal4":  # Inferno Avatar: a burning skull crowned in fire
        A.poly(flame_pts(8, 15.0, 11.0, 14.0, 0.0), m, 0.9)
        A.poly(flame_pts(8, 15.0, 7.0, 10.0, 0.5), (255, 200, 80), 0.9)
        A.ellipse(8, 9.6, 3.6, 3.8, (40, 10, 4))
        A.rect(6.2, 12.4, 9.8, 14.2, (40, 10, 4))
        A.circle(6.6, 9.4, 1.0, W).circle(9.4, 9.4, 1.0, W)
        A.circle(6.6, 9.4, 1.6, (255, 230, 120), 0.5, blur=0.6).circle(9.4, 9.4, 1.6, (255, 230, 120), 0.5, blur=0.6)
    elif key == "void1":  # Void Step: stepping through a portal
        A.ellipse(9.6, 8, 3.3, 5.8, (8, 0, 20)).ring(9.6, 8, 3.3, 1.2, lc(m, 0.35), ry=5.8)
        A.ring(9.6, 8, 4.4, 0.8, m, 0.5, ry=6.8, blur=0.4)
        for i, x in enumerate((1.8, 3.6, 5.4)):
            A.circle(x, 8 + (i - 1) * 0.4, 0.6 + i * 0.25, lc(m, 0.2 + i * 0.2), 0.4 + i * 0.25)
        A.poly([(6.2, 6.0), (9.4, 8), (6.2, 10.0)], W, 0.9)
    elif key == "void2":  # Rift Orb: an orb split by a tear
        A.circle(8, 8, 6.0, m, 0.5, blur=1.0).circle(8, 8, 5.0, (20, 0, 46)).ring(8, 8, 5.0, 1.0, lc(m, 0.3))
        r = [(4.2, 4.4), (7.0, 7.0), (6.2, 8.4), (9.6, 9.6), (8.8, 11.0), (11.8, 12.0)]
        A.line(r, 1.8, lc(m, 0.4), 0.8, blur=0.4).line(r, 0.7, W)
        A.circle(13.0, 3.4, 0.7, W).circle(2.8, 12.4, 0.5, lc(m, 0.6))
    elif key == "void3":  # Displace: two bodies swapping places
        A.arc(8, 8, 5.2, 200, 330, 1.2, lc(m, 0.4)).poly([(12.6, 4.2), (13.6, 6.8), (11.0, 6.4)], lc(m, 0.4))
        A.arc(8, 8, 5.2, 20, 150, 1.2, m).poly([(3.4, 11.8), (2.4, 9.2), (5.0, 9.6)], m)
        A.circle(4.6, 6.4, 1.6, W).circle(11.4, 9.6, 1.6, (20, 0, 46)).ring(11.4, 9.6, 1.6, 0.8, lc(m, 0.5))
    elif key == "void4":  # Singularity: black hole and accretion disk
        A.ring(8, 8.4, 6.6, 1.3, mixc(m, (255, 255, 255), 0.3), ry=2.3, rot=-12)
        A.circle(8, 8, 3.5, lc(m, 0.6), 0.8, blur=0.6).circle(8, 8, 3.0, (0, 0, 0))
        A.arc(8, 8.4, 6.6, 15, 165, 1.3, W)
        A.line(arc_pts(8, 8.4, 6.6, 20, 160)[2:-2], 0.5, W)
    elif key == "frozen1":  # Ice Shard: a long crystal spear
        ax = [(2.6, 13.4), (13.4, 2.6)]
        A.poly([(2.6, 13.4), (6.0, 8.4), (13.4, 2.6), (8.0, 10.4)], lc(m, 0.15))
        A.poly([(2.6, 13.4), (6.0, 8.4), (13.4, 2.6)], lc(m, 0.6))
        A.line(ax, 0.5, W, 0.8)
        A.poly([(10.6, 11.4), (12.0, 9.2), (13.4, 13.6)], dk(s, 0.0)).poly([(3.0, 4.4), (5.2, 3.2), (4.4, 6.4)], lc(m, 0.3))
    elif key == "frozen2":  # Glacial Wall: ice pillars erupting
        A.line([(1.5, 13.8), (14.5, 13.8)], 1.0, lc(s, 0.2))
        for x0, x1, top, c in ((1.8, 6.2, 5.0, lc(m, 0.1)), (5.4, 10.6, 2.0, lc(m, 0.45)), (9.8, 14.2, 5.6, lc(m, 0.2))):
            cx = (x0 + x1) / 2
            A.poly([(x0, 13.6), (x0, top + 2), (cx, top), (x1, top + 2), (x1, 13.6)], c)
            A.poly([(cx, top), (x1, top + 2), (x1, 13.6), (cx, 13.6)], s, 0.45)
            A.line([(cx - 0.6, top + 2.2), (cx - 0.6, 11.8)], 0.5, W, 0.8)
    elif key == "frozen3":  # Frost Nova: a ring of shards bursting outward
        A.circle(8, 8, 4.0, lc(m, 0.3), 0.4, blur=1.0).ring(8, 8, 3.6, 1.0, lc(m, 0.5))
        for k in range(8):
            a = math.radians(k * 45 + 22.5)
            c, sn = math.cos(a), math.sin(a)
            p0 = (8 + 4.6 * c, 8 + 4.6 * sn)
            A.poly([(p0[0] - sn * 1.0, p0[1] + c * 1.0), (8 + 7.4 * c, 8 + 7.4 * sn), (p0[0] + sn * 1.0, p0[1] - c * 1.0)], lc(m, 0.2 if k % 2 else 0.6))
        A.star(8, 8, 2.2, 0.7, 6, W)
    elif key == "frozen4":  # Absolute Zero: a great snowflake
        A.ring(8, 8, 6.6, 0.8, s, 0.8)
        for k in range(6):
            a = math.radians(k * 60 - 90)
            c, sn = math.cos(a), math.sin(a)
            A.line([(8, 8), (8 + 6 * c, 8 + 6 * sn)], 1.0, W)
            for d in (3.0, 4.6):
                bx, by = 8 + d * c, 8 + d * sn
                for sg in (-1, 1):
                    b = a + sg * math.radians(50)
                    A.line([(bx, by), (bx + 1.5 * math.cos(b), by + 1.5 * math.sin(b))], 0.7, lc(m, 0.5))
        A.poly(ellipse_pts(8, 8, 1.6, 1.6, 30, 6), lc(m, 0.3))
    elif key == "storm1":  # Lightning Strike: a bolt from the cloud
        for x, y, r in ((4.6, 4.4, 2.4), (8.2, 3.6, 3.0), (11.6, 4.6, 2.3), (8, 5.4, 2.6)):
            A.circle(x, y, r, (150, 168, 200))
        A.line([(3, 6.4), (13, 6.4)], 0.8, (90, 104, 136))
        bolt = [(9.2, 6.0), (5.8, 10.2), (8.4, 10.2), (6.0, 15.0), (11.2, 8.8), (8.6, 8.8), (10.6, 6.0)]
        A.poly(bolt, m, 0.6, blur=0.8).poly(bolt, (255, 250, 200))
    elif key == "storm2":  # Gale Burst: a gust spiral
        pts = [(8 + (0.4 + t * 5.6) * math.cos(t * 5.2 + 1), 8 + (0.4 + t * 5.6) * math.sin(t * 5.2 + 1)) for t in np.linspace(0, 1, 40)]
        A.line(pts, 1.4, lc(m, 0.55))
        for y, x0, ln in ((3.0, 1.5, 4.5), (13.2, 9.0, 5.0), (12.0, 1.0, 3.0)):
            A.line([(x0, y), (x0 + ln, y)], 0.8, lc(s, 0.0), 0.8)
    elif key == "storm3":  # Chain Lightning: arcs leaping between targets
        nodes = [(3.0, 4.0), (12.6, 6.6), (4.6, 12.6), (12.2, 13.0)]
        r2 = np.random.default_rng(5)
        for a, b in zip(nodes, nodes[1:]):
            p = jag(a, b, 5, 0.8, r2)
            A.line(p, 1.6, m, 0.6, blur=0.5).line(p, 0.6, W)
        for x, y in nodes:
            A.circle(x, y, 1.5, lc(m, 0.3)).circle(x, y, 0.7, W)
    elif key == "storm4":  # Tempest: a tornado with a bolt
        for i, y in enumerate(np.linspace(3, 13.5, 7)):
            w = 6.2 - i * 0.85
            cx = 8 + math.sin(i * 0.9) * 0.9
            A.ring(cx, y, w, 0.9, mixc((120, 140, 180), m, i / 7), ry=0.9)
        A.poly([(13.4, 6.0), (11.6, 9.0), (12.8, 9.0), (11.2, 12.6), (14.4, 8.2), (13.2, 8.2), (14.6, 6.0)], (255, 250, 190))
    elif key == "blood1":  # Blood Spike: spikes of blood from the ground
        A.line([(1.5, 13.8), (14.5, 13.8)], 1.2, dk(m, 0.4))
        for x0, x1, tip, c in ((2.4, 6.2, (4.0, 5.8), lc(m, 0.15)), (5.8, 10.4, (8.0, 2.0), lc(m, 0.35)), (9.8, 13.6, (11.8, 6.6), lc(m, 0.15))):
            A.poly([(x0, 13.6), tip, (x1, 13.6)], c)
            A.line([tip, ((tip[0] + x1) / 2 - 0.4, 13.0)], 0.5, (255, 120, 130), 0.8)
        A.poly(drop_pts(13.6, 4.2, 0.9), lc(m, 0.2)).poly(drop_pts(2.6, 3.2, 0.7), lc(m, 0.2))
    elif key == "blood2":  # Crimson Pact: a blade over a blood rune circle
        A.ring(8, 8, 6.0, 0.8, dk(m, 0.1))
        for k in range(6):
            a = math.radians(k * 60 + 30)
            A.circle(8 + 6 * math.cos(a), 8 + 6 * math.sin(a), 0.7, lc(m, 0.4))
        A.poly([(7.1, 4.4), (8.9, 4.4), (8.0, 12.6)], (225, 225, 235)).poly([(8.0, 4.4), (8.9, 4.4), (8.0, 12.6)], (150, 150, 165))
        A.rect(5.0, 3.4, 11.0, 4.4, (200, 160, 70)).rect(7.4, 0.8, 8.6, 3.4, (90, 30, 30))
        A.poly(drop_pts(8, 13.6, 1.1), lc(m, 0.3))
    elif key == "blood3":  # Siphon: drops drawn into a heart
        pts = bez((2.2, 2.4), (3.4, 10.4), (9.8, 10.0), 6)
        for i, (x, y) in enumerate(pts[:-1]):
            A.poly(drop_pts(x, y, 0.55 + i * 0.12, 1.8), lc(m, 0.1 + i * 0.06))
        A.poly(heart_pts(11.0, 10.2, 4.4), lc(m, 0.25)).poly(heart_pts(10.4, 9.6, 1.6), (255, 150, 160), 0.7)
    elif key == "blood4":  # Blood Moon: a crimson moon with a dark crescent
        A.circle(8, 8, 6.6, m, 0.5, blur=1.2).circle(8, 8, 5.6, lc(m, 0.35))
        A.circle(10.4, 6.6, 4.8, dk(m, 0.5), 0.6)
        for x, y, r in ((5.6, 6.4, 1.0), (7.2, 10.6, 1.3), (4.6, 9.6, 0.6)):
            A.circle(x, y, r, dk(m, 0.2))
        A.line([(1.5, 13.4), (6.0, 13.0), (9.0, 13.6), (14.5, 13.2)], 0.9, lc(m, 0.2), 0.7)
    elif key == "titan1":  # Ground Slam: a stone fist cracking the earth
        A.rect(1.5, 11.2, 14.5, 14.4, dk(s, 0.3))
        for p in ([(8, 11.2), (5.6, 12.6), (3.0, 12.4), (1.6, 14.0)], [(8, 11.2), (10.6, 12.8), (13.8, 12.2)], [(8, 11.2), (8.4, 14.4)]):
            A.line(p, 0.8, (20, 16, 12))
        A.poly([(5.0, 2.0), (11.0, 2.0), (11.6, 8.4), (10.0, 10.4), (6.0, 10.4), (4.4, 8.4)], lc(s, 0.3))
        for x in (6.2, 8.0, 9.8):
            A.line([(x, 7.2), (x, 10.0)], 0.6, dk(s, 0.4))
        A.rect(4.8, 2.0, 11.2, 3.6, m)
        for x, y in ((3.0, 9.6), (13.2, 9.0), (2.4, 7.0)):
            A.rect(x, y, x + 1.0, y + 1.0, lc(s, 0.2))
    elif key == "titan2":  # Stone Skin: a stone shield bound in gold
        sh = [(8, 1.6), (13.4, 3.2), (12.8, 9.0), (8, 14.4), (3.2, 9.0), (2.6, 3.2)]
        A.poly(sh, lc(s, 0.25)).line(sh + sh[:2], 1.1, m)
        A.line([(5.0, 4.4), (7.0, 7.0), (6.2, 9.4)], 0.6, dk(s, 0.5)).line([(11.2, 5.2), (9.6, 8.0), (10.4, 10.6)], 0.6, dk(s, 0.5))
        A.poly(ellipse_pts(8, 7.6, 1.6, 1.6, 45, 4), lc(m, 0.4))
    elif key == "titan3":  # Boulder Toss: a hurled boulder
        for y, x0 in ((6.2, 1.0), (9.4, 0.6), (12.4, 1.6)):
            A.line([(x0, y), (x0 + 3.6, y - 0.6)], 0.9, lc(m, 0.2), 0.7)
        rock = [(6.0, 6.4), (8.6, 3.0), (12.6, 3.4), (14.6, 7.2), (13.4, 11.6), (9.2, 12.8), (5.8, 10.4)]
        A.poly(rock, s).poly([(8.6, 3.0), (12.6, 3.4), (14.6, 7.2), (10.6, 7.0)], lc(s, 0.35))
        A.line([(10.6, 7.0), (9.2, 12.8)], 0.5, dk(s, 0.5)).line([(10.6, 7.0), (5.8, 10.4)], 0.5, dk(s, 0.5))
    elif key == "titan4":  # Colossus: a giant's crested helm
        A.poly([(3.0, 14.4), (3.0, 7.0), (5.0, 3.6), (8, 2.6), (11.0, 3.6), (13.0, 7.0), (13.0, 14.4)], lc(s, 0.15))
        A.poly([(5.0, 7.4), (11.0, 7.4), (11.0, 8.8), (9.0, 8.8), (9.0, 14.4), (7.0, 14.4), (7.0, 8.8), (5.0, 8.8)], (14, 10, 8))
        A.line([(8, 2.6), (8, 0.8)], 1.0, m).poly([(4.4, 2.6), (8, 0.6), (11.6, 2.6), (8, 1.8)], m)
        A.line([(3.0, 7.0), (13.0, 7.0)], 0.7, m)
    elif key == "celestial1":  # Starfall: falling stars
        for cx, cy, r in ((11.0, 4.4, 2.6), (5.4, 8.6, 2.0), (11.6, 12.0, 1.6)):
            A.line([(cx + 1.0, cy - 1.0), (cx + 4.5, cy - 4.5)], r * 0.7, s, 0.5)
            A.star(cx, cy, r, r * 0.4, 4, lc(m, 0.3)).circle(cx, cy, r * 0.3, W)
    elif key == "celestial2":  # Sanctuary: a holy dome
        A.line([(1.5, 13.4), (14.5, 13.4)], 1.0, s)
        A.poly(arc_pts(8, 13.2, 6.2, 180, 360, 24), lc(m, 0.2), 0.35)
        A.arc(8, 13.2, 6.2, 180, 360, 1.2, lc(m, 0.5))
        A.line([(8, 6.6), (8, 12.2)], 1.1, s).line([(6.0, 8.6), (10.0, 8.6)], 1.1, s)
    elif key == "celestial3":  # Radiant Beam: a pillar of light
        A.rect(4.8, 0.5, 11.2, 12.4, lc(m, 0.2), 0.45, blur=0.8).rect(6.6, 0.5, 9.4, 12.4, W)
        A.ellipse(8, 12.6, 5.6, 1.6, s)
        for k in range(5):
            a = math.radians(200 + k * 35)
            A.line([(8 + 3 * math.cos(a), 12.6 + 1.6 * math.sin(a)), (8 + 6.8 * math.cos(a), 12.6 + 3.6 * math.sin(a))], 0.6, lc(m, 0.4))
    elif key == "celestial4":  # Ascension: wings and a halo
        A.ring(8, 3.0, 2.6, 0.9, s, ry=0.9)
        for sg in (-1, 1):
            pts = [(8 + sg * 1.2, 7.6), (8 + sg * 6.6, 3.8), (8 + sg * 6.8, 6.4), (8 + sg * 6.0, 9.0),
                   (8 + sg * 4.4, 11.2), (8 + sg * 1.6, 11.0)]
            A.poly(pts, lc(m, 0.25))
            for k in range(3):
                A.line([(8 + sg * 1.8, 8.4 + k), (8 + sg * (6.0 - k * 0.9), 5.0 + k * 2.0)], 0.4, s, 0.8)
        A.ellipse(8, 9.0, 1.3, 2.6, W)
    elif key == "corruption1":  # Plague Bolt: a toxic glob with a trail
        trail = [(2.0, 14.0), (4.6, 11.0), (6.2, 11.6), (8.6, 7.8)]
        A.line(trail, 2.2, s, 0.8).line(trail, 0.9, lc(m, 0.2), 0.8)
        A.circle(10.6, 5.6, 3.2, m, 0.5, blur=0.8).circle(10.6, 5.6, 2.6, m)
        A.circle(9.8, 4.8, 0.7, (40, 70, 20)).circle(11.6, 6.4, 0.6, (40, 70, 20)).circle(11.2, 4.4, 0.45, (220, 255, 160))
        A.poly(drop_pts(4.0, 7.4, 0.6), lc(m, 0.3))
    elif key == "corruption2":  # Rot Ground: a bubbling bog and fumes
        A.ellipse(8, 12.2, 6.6, 2.2, s).ellipse(8, 12.0, 5.2, 1.4, dk(m, 0.2))
        for x, y, r in ((5.4, 10.4, 1.0), (9.6, 9.6, 1.4), (11.6, 11.4, 0.7)):
            A.ring(x, y, r, 0.5, lc(m, 0.3))
        for x in (5.0, 8.6, 11.8):
            A.line([(x, 8.2), (x - 0.8, 6.4), (x + 0.4, 4.6), (x - 0.4, 2.6)], 0.7, lc(s, 0.3), 0.8)
    elif key == "corruption3":  # Infest: crawling beetles
        for cx, cy, rot in ((5.0, 5.0, -35), (11.0, 7.0, 20), (6.4, 11.6, 60)):
            for k in (-1, 0, 1):
                a = math.radians(rot + 90 + k * 30)
                A.line([(cx - 2.4 * math.cos(a), cy - 2.4 * math.sin(a)), (cx + 2.4 * math.cos(a), cy + 2.4 * math.sin(a))], 0.4, s)
            A.ellipse(cx, cy, 2.0, 1.3, mixc(m, s, 0.4), rot=rot)
            A.circle(cx + 2.0 * math.cos(math.radians(rot)), cy + 2.0 * math.sin(math.radians(rot)), 0.8, dk(s, 0.3))
            A.line([(cx - 1.6 * math.cos(math.radians(rot)), cy - 1.6 * math.sin(math.radians(rot))), (cx + 1.6 * math.cos(math.radians(rot)), cy + 1.6 * math.sin(math.radians(rot)))], 0.3, lc(m, 0.5))
    elif key == "corruption4":  # Pandemic: a biohazard sigil
        A.circle(8, 8, 6.6, s, 0.6, blur=1.0)
        for k in range(3):
            a = math.radians(-90 + k * 120)
            A.ring(8 + 3.1 * math.cos(a), 8 + 3.1 * math.sin(a), 2.8, 1.1, m)
        A.ring(8, 8, 2.0, 0.9, lc(m, 0.3)).circle(8, 8, 0.8, lc(m, 0.6))
        for x, y in ((2.0, 13.4), (13.8, 2.6), (14.0, 13.0)):
            A.circle(x, y, 0.6, lc(m, 0.4))
    else:
        raise SystemExit(f"no icon for {key}")


def ability_icons():
    g = GLYPHS["abilities"]
    base = int(g["base"], 16)
    imask = interior_mask()
    for i, (kind, main, sec) in enumerate(HEARTS):
        for slot in range(1, 5):
            rng = np.random.default_rng(i * 10 + slot)
            img = icon_base(main, sec, rng)
            A = Art(16, 16, 6)
            draw_ability(kind, slot, A, col3(main), col3(sec), rng)
            sym = outlined(A.img)
            sym[..., 3] *= imask
            over_img(img, sym)
            icon_frame(col3(main), img)
            path = g["texture"].replace("<h>", kind).replace("<slot>", str(slot)).split(":", 1)[1]
            font_add(fname(g["font"]), path, g["ascent"], g["height"], chr(base + i * 4 + slot - 1), img)


def padlock():
    img = blank(16, 16)
    over(img, (6, 4, 10), interior_mask() * 0.78)
    A = Art(16, 16, 6)
    A.arc(8, 6.6, 2.6, 180, 360, 1.3, (200, 200, 210))
    A.line([(5.4, 6.6), (5.4, 8.0)], 1.3, (200, 200, 210), cap=False).line([(10.6, 6.6), (10.6, 8.0)], 1.3, (200, 200, 210), cap=False)
    A.rect(4.2, 7.6, 11.8, 13.0, (225, 190, 90)).rect(4.2, 7.6, 11.8, 8.6, (255, 230, 150))
    A.circle(8, 10.0, 0.9, (40, 26, 8)).rect(7.6, 10.2, 8.4, 11.8, (40, 26, 8))
    over_img(img, outlined(A.img))
    return icon_frame((120, 120, 130), img)


def hud_extras():
    ex = GLYPHS["ability_extra"]
    font, asc, hgt = fname(ex["font"]), ex["ascent"], ex["height"]
    imask = interior_mask()
    for name, code in ex["glyphs"].items():
        if name == "lock":
            img = padlock()
        elif name == "frame":
            img = icon_frame((150, 150, 160), blank(16, 16))
        elif name == "ready_frame":
            img = blank(16, 16)
            u, v = uv_grid(16, 16)
            d = np.minimum.reduce([u * 16 - 0.5, 15.5 - u * 16, v * 16 - 0.5, 15.5 - v * 16])
            glow = np.clip(1.0 - d / 3.2, 0, 1) ** 1.6
            over(img, (255, 248, 220), glow * 0.85)
            for y in range(16):
                for x in range(16):
                    if (x in (0, 15) and y in (0, 15)):
                        img[y, x] = 0
                    elif x in (0, 15) or y in (0, 15) or (x in (1, 14) and y in (1, 14)):
                        img[y, x] = [255, 255, 255, 255]
            for x, y in ((1, 1), (14, 1), (1, 14), (14, 14), (8, 0), (0, 8), (15, 8), (8, 15)):
                img[y, x] = [255, 255, 255, 255]
        else:
            k = int(name.split("_")[1])
            img = blank(16, 16)
            if k:
                cov = np.zeros((16, 16))
                cov[: k * 2] = 1
                over(img, (0, 0, 0), cov * imask * 0.72)
        path = f"gui/hud/{name}.png"
        font_add(font, path, asc, hgt, cp(code), img)


DIGITS = ["111101101101111", "010110010010111", "111001111100111", "111001111001111", "101101111001001",
          "111100111001111", "111100111101111", "111001010010010", "111101111101111", "111101111001111"]


def hud_digits():
    g = GLYPHS["digits"]
    base = int(g["base"], 16)
    for n, bits in enumerate(DIGITS):
        img = blank(5, 3)
        for k, b in enumerate(bits):
            if b == "1":
                img[k // 3, k % 3] = [255, 255, 255, 255]
        path = g["texture"].replace("<n>", str(n)).split(":", 1)[1]
        font_add(fname(g["font"]), path, g["ascent"], g["height"], chr(base + n), img)


def hud_meters():
    g = GLYPHS["meter"]
    base = int(g["base"], 16)
    W, H = 74, 4
    for n in range(21):
        img = blank(H, W)
        img[:, :, :3] = 0
        img[:, 1:-1, 3] = 190
        img[1:-1, 0, 3] = 190
        img[1:-1, -1, 3] = 190
        img[1:-1, 1:-1] = [255, 255, 255, 60]
        fill = round(n * (W - 2) / 20)
        if fill:
            img[1, 1:1 + fill] = [255, 255, 255, 255]
            img[2, 1:1 + fill] = [200, 200, 200, 255]
            if fill < W - 2:
                img[1:3, fill] = [255, 255, 255, 255]
        for x in range(9, W - 2, 9):  # segment ticks
            if x > fill:
                img[1:3, x, 3] = 110
        path = g["texture"].replace("<n>", str(n)).split(":", 1)[1]
        font_add(fname(g["font"]), path, g["ascent"], g["height"], chr(base + n), img)


# ---- full screen overlays

OW, OH = 512, 280


def walks(rng, n, starts, steps, step, jitter, branch=0.08, width=3.0, depth=2):
    """Branching random walks (cracks, veins, frost). Returns [(pts, width)] in short tapered pieces."""
    out = []

    def go(x, y, ang, steps_left, w, d):
        pts = [(x, y)]
        for k in range(steps_left):
            ang += rng.normal(0, jitter)
            x += math.cos(ang) * step
            y += math.sin(ang) * step
            pts.append((x, y))
            if d > 0 and rng.random() < branch:
                go(x, y, ang + rng.choice([-1, 1]) * rng.uniform(0.4, 1.0), int((steps_left - k) * 0.6), w * 0.6, d - 1)
            if k % 4 == 3:
                out.append((pts, w))
                w *= 0.93
                pts = [(x, y)]
        if len(pts) > 1:
            out.append((pts, w))

    for _ in range(n):
        x, y, ang = starts(rng)
        go(x, y, ang, steps, width, depth)
    return out


def edge_start(rng):
    side = rng.integers(0, 4)
    if side == 0:
        x, y = rng.uniform(0, OW), -2.0
    elif side == 1:
        x, y = rng.uniform(0, OW), OH + 2.0
    elif side == 2:
        x, y = -2.0, rng.uniform(0, OH)
    else:
        x, y = OW + 2.0, rng.uniform(0, OH)
    ang = math.atan2(OH / 2 - y, OW / 2 - x) + rng.normal(0, 0.5)
    return x, y, ang


def corner_start(rng):
    cx, cy = [(0, 0), (OW, 0), (0, OH), (OW, OH)][rng.integers(0, 4)]
    x = cx + (rng.uniform(0, 120) if cx == 0 else -rng.uniform(0, 120))
    y = cy + (rng.uniform(0, 70) if cy == 0 else -rng.uniform(0, 70))
    return x, y, math.atan2(OH / 2 - y, OW / 2 - x) + rng.normal(0, 0.6)


def overlay(name):
    rng = np.random.default_rng(sum(map(ord, name)) * 131)
    W, H = OW, OH
    u, v = uv_grid(H, W)
    ex, ey = u * 2 - 1, v * 2 - 1
    re = np.hypot(ex, ey)
    sup = (np.abs(ex) ** 4 + np.abs(ey) ** 4) ** 0.25
    n1 = pnoise(H, W, rng, 1.8)
    n2 = pnoise(H, W, rng, 1.2)
    img = blank(H, W)
    A = Art(W, H, 2)
    A.img = img
    if name == "vignette":
        over(img, (255, 255, 255), smooth(0.35, 1.2, re) ** 1.4 * (0.85 + 0.15 * n1))
    elif name == "flash":
        over(img, (255, 255, 255), 0.5 + 0.38 * smooth(0.1, 1.25, re))
    elif name == "rage":
        over(img, mixc((90, 0, 0), (200, 10, 20), n1[..., None]), smooth(0.5, 1.25, re + 0.2 * (n1 - 0.5)) * 0.8)
        cr = walks(rng, 34, edge_start, 26, 7, 0.35, 0.12, 4.0, 2)
        fade = smooth(0.25, 0.85, re)
        g = A.mask(lambda d, s: [d.line([(x * s, y * s) for x, y in p], fill=255, width=max(1, int(w * 3 * s)), joint="curve") for p, w in cr], blur=4)
        c = A.mask(lambda d, s: [d.line([(x * s, y * s) for x, y in p], fill=255, width=max(1, int(w * s)), joint="curve") for p, w in cr])
        over(img, (255, 40, 30), g * fade * 0.8)
        over(img, (60, 0, 0), c * fade)
        over(img, (255, 120, 90), A.mask(lambda d, s: [d.line([(x * s, y * s) for x, y in p], fill=255, width=max(1, int(w * 0.35 * s)), joint="curve") for p, w in cr]) * fade * 0.8)
    elif name == "speed":
        over(img, (255, 255, 255), smooth(0.6, 1.3, re) * 0.25)
        R = math.hypot(W, H) / 2 + 10
        for k in range(190):
            a = rng.uniform(0, 2 * math.pi)
            r0 = rng.uniform(0.42, 0.85) * R
            w = rng.uniform(0.6, 3.2)
            c, s_ = math.cos(a), math.sin(a)
            p0 = (W / 2 + c * r0, H / 2 + s_ * r0 * 0.75)
            p1 = (W / 2 + c * R * 1.2 - s_ * w, H / 2 + s_ * R * 0.9 + c * w)
            p2 = (W / 2 + c * R * 1.2 + s_ * w, H / 2 + s_ * R * 0.9 - c * w)
            col = [(255, 255, 255), (255, 245, 170), (180, 240, 255)][k % 3]
            A.poly([p0, p1, p2], col, rng.uniform(0.45, 0.95))
    elif name == "infernal":
        heat = smooth(0.55, 1.2, re + 0.2 * (v - 0.5) + 0.25 * (n1 - 0.5))
        col = mixc((150, 20, 0), (255, 180, 50), np.clip(n2 * 1.4 - 0.2 + (v - 0.5), 0, 1)[..., None])
        over(img, col, heat * 0.85)
        fl = pnoise(H, W, rng, 1.6, (1.0, 0.25))
        tongues = smooth(0.0, 0.5, (v - 0.78) * 3.0 + (fl - 0.5) * 0.9)
        over(img, mixc((255, 90, 0), (255, 240, 160), tongues[..., None] ** 2), tongues * 0.75)
        for _ in range(220):
            x, y = rng.uniform(0, W), rng.uniform(0, H)
            e = math.hypot(x / W * 2 - 1, y / H * 2 - 1)
            if e < 0.55 and rng.random() < 0.8:
                continue
            r = rng.uniform(0.6, 2.4)
            A.circle(x, y, r * 3, (255, 120, 20), 0.35, blur=2).circle(x, y, r, (255, 230, 150), rng.uniform(0.6, 1))
    elif name == "void":
        d = sup + 0.22 * (n1 - 0.5) + 0.08 * (n2 - 0.5)
        outside = smooth(0.80, 0.84, d)
        stars = (rng.random((H, W)) > 0.996) * outside
        dark = mixc((10, 0, 24), (40, 0, 70), n2[..., None])
        over(img, dark, outside * 0.94)
        over(img, (255, 255, 255), stars)
        over(img, (150, 70, 255), gauss(d - 0.82, 0.06) * 0.6)
        over(img, (230, 200, 255), gauss(d - 0.815, 0.012))
        over(img, (90, 20, 160), smooth(0.4, 1.0, re) * 0.25)
    elif name == "frozen":
        k = np.sqrt(np.abs(ex * ey))
        frost = smooth(0.42, 0.85, k + 0.35 * (n1 - 0.5) + 0.25 * sup - 0.1)
        over(img, mixc((170, 220, 255), (250, 255, 255), n2[..., None]), frost * 0.8)
        cr = walks(rng, 30, corner_start, 22, 6, 0.25, 0.22, 2.4, 3)
        g = A.mask(lambda d_, s: [d_.line([(x * s, y * s) for x, y in p], fill=255, width=max(1, int(w * 2.6 * s)), joint="curve") for p, w in cr], blur=2)
        c = A.mask(lambda d_, s: [d_.line([(x * s, y * s) for x, y in p], fill=255, width=max(1, int(w * 0.8 * s)), joint="curve") for p, w in cr])
        fade = smooth(0.2, 0.7, re)
        over(img, (120, 200, 255), g * fade * 0.7)
        over(img, (255, 255, 255), c * fade)
    elif name == "storm":
        over(img, mixc((20, 30, 60), (70, 90, 130), n1[..., None]), smooth(0.55, 1.25, re + 0.25 * (n1 - 0.5)) * 0.75)
        bolts = []
        for _ in range(16):
            side = rng.integers(0, 4)
            if side < 2:
                y = rng.uniform(2, 30) if side == 0 else H - rng.uniform(2, 30)
                x0 = rng.uniform(-20, W - 120)
                p0, p1 = (x0, y), (x0 + rng.uniform(80, 200), y + rng.normal(0, 14))
            else:
                x = rng.uniform(2, 40) if side == 2 else W - rng.uniform(2, 40)
                y0 = rng.uniform(-20, H - 60)
                p0, p1 = (x, y0), (x + rng.normal(0, 18), y0 + rng.uniform(50, 130))
            pts = jag(p0, p1, 14, 6, rng)
            bolts.append((pts, 2.2))
            for _ in range(2):
                j = int(rng.integers(2, 12))
                q = pts[j]
                bolts.append((jag(q, (q[0] + rng.normal(0, 40), q[1] + rng.normal(0, 40)), 6, 4, rng), 1.2))
        A.lines([(p, w * 5) for p, w in bolts], (60, 150, 255), 0.6, blur=4)
        A.lines([(p, w * 2) for p, w in bolts], (150, 210, 255), 0.9, blur=1)
        A.lines(bolts, (255, 255, 255), 1.0)
    elif name == "blood":
        over(img, (120, 0, 10), smooth(0.6, 1.3, re) * 0.5)
        for _ in range(16):
            x, y, _a = edge_start(rng)
            x = np.clip(x, 0, W)
            y = np.clip(y, 0, H)
            x += (W / 2 - x) * rng.uniform(0.0, 0.15)
            y += (H / 2 - y) * rng.uniform(0.0, 0.25)
            r = rng.uniform(10, 34)
            base = mixc((90, 0, 8), (170, 8, 24), rng.uniform(0, 1))
            blob = [(x + r * (0.75 + 0.35 * rng.random()) * math.cos(t), y + r * (0.75 + 0.35 * rng.random()) * math.sin(t)) for t in np.linspace(0, 2 * math.pi, 22, endpoint=False)]
            A.poly(blob, base, 0.92)
            A.circle(x - r * 0.3, y - r * 0.3, r * 0.25, lc(base, 0.3), 0.5, blur=2)
            for _ in range(int(rng.integers(6, 14))):
                a = rng.uniform(0, 2 * math.pi)
                dd = r * rng.uniform(1.1, 2.6)
                A.circle(x + math.cos(a) * dd, y + math.sin(a) * dd, rng.uniform(1, r * 0.22), base, 0.9)
            if y < H * 0.5:
                for _ in range(int(rng.integers(1, 4))):
                    dx = rng.uniform(-r * 0.6, r * 0.6)
                    ln = rng.uniform(20, 90)
                    A.line([(x + dx, y), (x + dx, y + ln)], rng.uniform(2, 4), base, 0.9)
                    A.circle(x + dx, y + ln, 3.0, base, 0.9)
    elif name == "titan":
        dust = smooth(0.5, 1.2, re + 0.3 * (v - 0.5) + 0.3 * (n1 - 0.5))
        over(img, mixc((110, 92, 70), (200, 182, 150), n2[..., None]), dust * 0.75)
        cr = walks(rng, 26, edge_start, 18, 9, 0.5, 0.15, 3.4, 2)
        fade = smooth(0.25, 0.8, re)
        over(img, (215, 195, 160), A.mask(lambda d, s: [d.line([(x * s + s, y * s + s) for x, y in p], fill=255, width=max(1, int(w * s)), joint="curve") for p, w in cr]) * fade * 0.8)
        over(img, (30, 24, 18), A.mask(lambda d, s: [d.line([(x * s, y * s) for x, y in p], fill=255, width=max(1, int(w * s)), joint="curve") for p, w in cr]) * fade)
        for _ in range(70):
            x, y, _a = edge_start(rng)
            x = float(np.clip(x, 0, W)) + rng.normal(0, 20)
            y = float(np.clip(y, 0, H)) + rng.normal(0, 14)
            r = rng.uniform(1.5, 6)
            rock = [(x + r * (0.7 + 0.5 * rng.random()) * math.cos(t), y + r * (0.7 + 0.5 * rng.random()) * math.sin(t)) for t in np.linspace(0, 2 * math.pi, 7, endpoint=False)]
            A.poly(rock, mixc((70, 60, 50), (150, 135, 110), rng.random()), 0.95)
    elif name == "celestial":
        sx, sy = W / 2, -80
        ang = np.arctan2(v * H - sy, u * W - sx)
        rays = (0.5 + 0.5 * np.sin(ang * 46 + 3 * np.sin(ang * 7))) ** 3
        dist_ = np.hypot(u * W - sx, v * H - sy) / H
        a = rays * smooth(1.9, 0.4, dist_) * (0.08 + 0.92 * smooth(0.35, 1.05, re)) * 0.65
        over(img, (255, 244, 190), a)
        over(img, (255, 214, 110), smooth(0.55, 1.25, re) * 0.55)
        for _ in range(60):
            x, y = rng.uniform(0, W), rng.uniform(0, H)
            if math.hypot(x / W * 2 - 1, y / H * 2 - 1) < 0.6:
                continue
            r = rng.uniform(2, 6)
            A.star(x, y, r, r * 0.25, 4, (255, 255, 235), rng.uniform(0.5, 1)).circle(x, y, r * 0.8, (255, 230, 150), 0.3, blur=2)
    elif name == "corruption":
        over(img, mixc((30, 6, 40), (70, 20, 90), n1[..., None]), smooth(0.5, 1.25, re + 0.3 * (n2 - 0.5)) * 0.8)
        cr = walks(rng, 30, edge_start, 30, 6, 0.45, 0.16, 3.6, 3)
        fade = smooth(0.2, 0.8, re)
        over(img, (120, 230, 60), A.mask(lambda d, s: [d.line([(x * s, y * s) for x, y in p], fill=255, width=max(1, int(w * 3 * s)), joint="curve") for p, w in cr], blur=3) * fade * 0.55)
        over(img, (60, 10, 80), A.mask(lambda d, s: [d.line([(x * s, y * s) for x, y in p], fill=255, width=max(1, int(w * s)), joint="curve") for p, w in cr]) * fade)
        for _ in range(90):
            x, y, _a = edge_start(rng)
            x = float(np.clip(x, 0, W)) + rng.normal(0, 40)
            y = float(np.clip(y, 0, H)) + rng.normal(0, 26)
            A.circle(x, y, rng.uniform(1, 3.5), (190, 255, 120), rng.uniform(0.4, 0.9))
    elif name == "eye":
        over(img, (0, 0, 0), 0.5 + 0.48 * smooth(0.2, 1.0, re))
        top = [(x, H / 2 - 120 * math.sin(math.pi * (x - 16) / (W - 32))) for x in np.linspace(16, W - 16, 60)]
        bot = [(x, H / 2 + 110 * math.sin(math.pi * (x - 16) / (W - 32))) for x in np.linspace(16, W - 16, 60)]
        A.line(top, 5, (120, 30, 170), 0.35, blur=3).line(bot, 5, (120, 30, 170), 0.35, blur=3)
        A.line(top, 1.6, (170, 80, 220), 0.35).line(bot, 1.6, (170, 80, 220), 0.35)
        A.ring(W / 2, H / 2, 88, 3, (150, 20, 40), 0.25, blur=2)
        A.ellipse(W / 2, H / 2, 16, 84, (90, 0, 20), 0.22, blur=3)
    elif name == "awaken":
        ang = np.arctan2(v * H - H / 2, u * W - W / 2)
        rays = (0.5 + 0.5 * np.sin(ang * 36)) ** 4 + 0.6 * (0.5 + 0.5 * np.sin(ang * 13 + 1)) ** 6
        over(img, mixc((255, 200, 80), (255, 255, 230), n1[..., None]), rays * smooth(0.25, 1.1, re) * 0.7)
        over(img, (255, 220, 120), gauss(re - 0.62, 0.06) * 0.6)
        over(img, (255, 200, 90), smooth(0.7, 1.3, re) * 0.7)
        for _ in range(80):
            a = rng.uniform(0, 2 * math.pi)
            rr = rng.uniform(0.55, 1.2)
            x, y = W / 2 + math.cos(a) * rr * W / 2, H / 2 + math.sin(a) * rr * H / 2
            r = rng.uniform(1.5, 5)
            A.star(x, y, r, r * 0.25, 4, (255, 255, 240), rng.uniform(0.6, 1))
    elif name == "shatter":
        cx, cy = W * 0.63, H * 0.42
        R = W * 1.2
        rad = []
        a0 = rng.uniform(0, 2 * math.pi)
        for k in range(20):
            a = a0 + k * 2 * math.pi / 20 + rng.normal(0, 0.08)
            rad.append(a)
        polys = []
        for a in rad:
            polys.append((jag((cx, cy), (cx + math.cos(a) * R, cy + math.sin(a) * R), 16, 3, rng), 1.6))
        rings = [14, 34, 70, 120, 190]
        for r in rings:
            for a, b in zip(rad, rad[1:] + [rad[0] + 2 * math.pi]):
                if rng.random() < 0.75:
                    rr = r * rng.uniform(0.85, 1.15)
                    polys.append((jag((cx + math.cos(a) * rr, cy + math.sin(a) * rr), (cx + math.cos(b) * rr * rng.uniform(0.9, 1.1), cy + math.sin(b) * rr * rng.uniform(0.9, 1.1)), 3, 1.5, rng), 1.0))
        for i, (a, b) in enumerate(zip(rad, rad[1:] + [rad[0] + 2 * math.pi])):
            if i % 3 == 0:
                r0, r1 = rings[1], rings[3]
                A.poly([(cx + math.cos(a) * r0, cy + math.sin(a) * r0), (cx + math.cos(a) * r1, cy + math.sin(a) * r1),
                        (cx + math.cos(b) * r1, cy + math.sin(b) * r1), (cx + math.cos(b) * r0, cy + math.sin(b) * r0)], (220, 235, 255), 0.12)
        A.lines([([(x + 1.2, y + 1.2) for x, y in p], w) for p, w in polys], (0, 0, 0), 0.5)
        A.lines([(p, w * 3) for p, w in polys], (255, 255, 255), 0.25, blur=1.5)
        A.lines(polys, (255, 255, 255), 0.95)
        A.circle(cx, cy, 10, (255, 255, 255), 0.6, blur=4)
    else:
        raise SystemExit(f"no overlay recipe for {name}")
    return A.img


def hud_overlays():
    g = GLYPHS["overlays"]
    for name, code in g["glyphs"].items():
        img = overlay(name)
        path = g["texture"].replace("<name>", name).split(":", 1)[1]
        font_add(fname(g["font"]), path, g["ascent"], g["height"], cp(code), img)
        print("overlay", name)


# ---- mastery dock (right of the hotbar)

FONT3 = {  # 3x5 caps, digits and a few marks; wider letters use more columns
    "A": ["010", "101", "111", "101", "101"], "B": ["110", "101", "110", "101", "110"], "C": ["011", "100", "100", "100", "011"],
    "D": ["110", "101", "101", "101", "110"], "E": ["111", "100", "110", "100", "111"], "F": ["111", "100", "110", "100", "100"],
    "G": ["011", "100", "101", "101", "011"], "H": ["101", "101", "111", "101", "101"], "I": ["111", "010", "010", "010", "111"],
    "J": ["001", "001", "001", "101", "010"], "K": ["101", "110", "100", "110", "101"], "L": ["100", "100", "100", "100", "111"],
    "M": ["10001", "11011", "10101", "10001", "10001"], "N": ["1001", "1101", "1011", "1001", "1001"], "O": ["010", "101", "101", "101", "010"],
    "P": ["110", "101", "110", "100", "100"], "Q": ["010", "101", "101", "110", "011"], "R": ["110", "101", "110", "101", "101"],
    "S": ["011", "100", "010", "001", "110"], "T": ["111", "010", "010", "010", "010"], "U": ["101", "101", "101", "101", "111"],
    "V": ["101", "101", "101", "101", "010"], "W": ["10001", "10001", "10101", "11011", "10001"], "X": ["101", "101", "010", "101", "101"],
    "Y": ["101", "101", "010", "010", "010"], "Z": ["111", "001", "010", "100", "111"], " ": ["00", "00", "00", "00", "00"],
    "0": ["111", "101", "101", "101", "111"], "1": ["010", "110", "010", "010", "111"], "2": ["111", "001", "111", "100", "111"],
    "3": ["111", "001", "111", "001", "111"], "4": ["101", "101", "111", "001", "001"], "5": ["111", "100", "111", "001", "111"],
    "6": ["111", "100", "111", "101", "111"], "7": ["111", "001", "010", "010", "010"], "8": ["111", "101", "111", "101", "111"],
    "9": ["111", "101", "111", "001", "111"],
}
BIG = [  # 5x7 digits
    ["01110", "10001", "10011", "10101", "11001", "10001", "01110"], ["00100", "01100", "00100", "00100", "00100", "00100", "01110"],
    ["01110", "10001", "00001", "00110", "01000", "10000", "11111"], ["11110", "00001", "00001", "01110", "00001", "00001", "11110"],
    ["00010", "00110", "01010", "10010", "11111", "00010", "00010"], ["11111", "10000", "11110", "00001", "00001", "10001", "01110"],
    ["00110", "01000", "10000", "11110", "10001", "10001", "01110"], ["11111", "00001", "00010", "00100", "01000", "01000", "01000"],
    ["01110", "10001", "10001", "01110", "10001", "10001", "01110"], ["01110", "10001", "10001", "01111", "00001", "00010", "01100"],
]
MW, MH = 112, 31
M_EMB = (14.5, 15.5)            # emblem centre
M_BAR = (31, 12, 78, 6)         # interior x, y, w, h of the main bar
M_SUB = (31, 21, 78, 1)         # interior of the XP-in-level bar
M_DIG = (93, 2)                 # first big digit slot (three slots, 6 px apart)


def text3(img, x, y, s, col, a=255, shadow=True):
    for ch in s:
        rows = FONT3.get(ch, FONT3[" "])
        for yy, row in enumerate(rows):
            for xx, b in enumerate(row):
                if b == "1":
                    if shadow and 0 <= y + yy + 1 < img.shape[0] and x + xx + 1 < img.shape[1] and img[y + yy + 1, x + xx + 1, 3] < 200:
                        img[y + yy + 1, x + xx + 1] = [12, 8, 16, 200]
                    img[y + yy, x + xx] = [col[0], col[1], col[2], a]
        x += len(rows[0]) + 1
    return x


def mastery_frame():
    img = blank(MH, MW)
    u, v = uv_grid(MH, MW)
    yy, xx = np.mgrid[0:MH, 0:MW].astype(np.float64)
    # plate: a slanted dark slab with a soft vertical gradient and faint diagonal grain
    plate = (xx >= 4 - (yy < 3) * 0) & (xx <= MW - 2) & (yy >= 1) & (yy <= MH - 2)
    plate &= ~((xx < 4 + (MH - 2 - yy) * 0.0) & False)
    grain = (((xx + yy * 2) % 7) == 0) * 6.0
    base = np.stack([16 + 10 * (1 - v) + grain, 12 + 6 * (1 - v) + grain, 22 + 12 * (1 - v) + grain], -1)
    over(img, base, plate * 0.86)
    # left wing reaching toward the hotbar
    wing = (xx < 4) & (yy >= 9 + xx) & (yy <= 21 - xx)
    over(img, (40, 30, 52), wing * 0.9)
    # bevel: light top-left, dark bottom-right edges
    edge = plate & ((yy == 1) | (xx == 4))
    over(img, (92, 80, 104), edge * 1.0)
    edge2 = plate & ((yy == MH - 2) | (xx == MW - 2))
    over(img, (6, 4, 8), edge2 * 1.0)
    # gold filigree corners
    gold = (214, 178, 96)
    for cx, cy, sx, sy in ((5, 2, 1, 1), (MW - 3, 2, -1, 1), (5, MH - 3, 1, -1), (MW - 3, MH - 3, -1, -1)):
        for k in range(6):
            for x_, y_ in ((cx + sx * k, cy), (cx, cy + sy * k)):
                if 0 <= y_ < MH and 0 <= x_ < MW:
                    img[y_, x_] = [gold[0], gold[1], gold[2], 255 - k * 30]
        img[cy + sy, cx + sx] = [255, 236, 170, 255]
        img[cy + sy * 2, cx + sx * 2] = [gold[0], gold[1], gold[2], 180]
    # emblem socket: dark disc with an engraved double ring
    cx, cy = M_EMB
    r = np.hypot(xx + 0.5 - cx, yy + 0.5 - cy)
    over(img, (6, 4, 10), smooth(13.6, 12.6, r))
    over(img, (60, 52, 70), (np.abs(r - 13.4) < 0.55) * 1.0)
    over(img, (34, 28, 42), (np.abs(r - 9.6) < 0.5) * 1.0)
    for k in range(12):  # tick marks around the socket
        a = k * math.pi / 6
        px, py = cx + math.sin(a) * 13.4, cy - math.cos(a) * 13.4
        img[int(py), int(px)] = [gold[0], gold[1], gold[2], 255]
    # title
    text3(img, M_BAR[0], 3, "MASTERY", (226, 206, 150))
    text3(img, M_DIG[0] - 10, 4, "LV", (150, 136, 170))
    # main bar slot: recessed groove with milestone notches and pip sockets
    bx, by, bw, bh = M_BAR
    over(img, (4, 2, 6), ((xx >= bx - 1) & (xx <= bx + bw) & (yy >= by - 1) & (yy <= by + bh)) * 1.0)
    over(img, (26, 22, 32), ((xx >= bx) & (xx < bx + bw) & (yy >= by) & (yy < by + bh)) * 1.0)
    over(img, (70, 60, 84), ((xx >= bx - 1) & (xx <= bx + bw) & (yy == by + bh + 1)) * 0.8)
    for x_ in range(bx, bx + bw, 4):
        img[by + bh - 1, x_] = [44, 38, 52, 255]
    for m in GLYPHS["mastery"]["milestones"]:
        x_ = bx + round(m * (bw - 1) / 100)
        img[by:by + bh, x_] = [10, 8, 14, 255]
        img[by - 3, x_] = [80, 70, 92, 255]
        img[by - 2, x_ - 1:x_ + 2] = [80, 70, 92, 255]
    # sub bar groove
    sx, sy, sw, sh = M_SUB
    over(img, (4, 2, 6), ((xx >= sx - 1) & (xx <= sx + sw) & (yy >= sy - 1) & (yy <= sy + sh)) * 1.0)
    over(img, (34, 30, 44), ((xx >= sx) & (xx < sx + sw) & (yy >= sy) & (yy < sy + sh)) * 1.0)
    return img


def mastery_trim():
    """White trim that takes the heart colour: lines along the top and bottom edges and a rim on the socket."""
    img = blank(MH, MW)
    yy, xx = np.mgrid[0:MH, 0:MW].astype(np.float64)
    top = (yy == 0) & (xx >= 12) & (xx <= MW - 10)
    bot = (yy == MH - 1) & (xx >= 12) & (xx <= MW - 10)
    over(img, (255, 255, 255), top * smooth(12, 30, xx) * smooth(MW - 10, MW - 30, xx))
    over(img, (255, 255, 255), bot * 0.7 * smooth(12, 30, xx) * smooth(MW - 10, MW - 30, xx))
    cx, cy = M_EMB
    r = np.hypot(xx + 0.5 - cx, yy + 0.5 - cy)
    over(img, (255, 255, 255), (np.abs(r - 14.3) < 0.5) * 0.85)
    # chevrons pointing at the hotbar
    for k in range(3):
        for d in range(3):
            img[15 - d, 1 + k + d] = [255, 255, 255, 200 - k * 50]
            img[15 + d, 1 + k + d] = [255, 255, 255, 200 - k * 50]
    return img


def mastery_ring(k, n=24):
    """Emblem ring filled clockwise from the top: k of n segments, white with a bright leading edge."""
    img = blank(MH, MW)
    yy, xx = np.mgrid[0:MH, 0:MW].astype(np.float64)
    cx, cy = M_EMB
    dx, dy = xx + 0.5 - cx, yy + 0.5 - cy
    r = np.hypot(dx, dy)
    ang = (np.degrees(np.arctan2(dx, -dy)) + 360) % 360
    band = (r >= 10.2) & (r <= 12.8)
    seg = (ang % 15) > 1.6
    lit = ang < k * 360 / n
    lum = 170 + 85 * smooth(10.2, 12.8, r)
    over(img, np.stack([lum, lum, lum], -1), band & seg & lit)
    if 0 < k < n:
        lead = band & (np.abs(ang - k * 360 / n) < 7)
        over(img, (255, 255, 255), lead * 1.0)
    return img


def mastery_gem(main, sec):
    img, inside, _, _ = shade_heart(main, sec, 0.95, np.random.default_rng(7))
    g = to_image(img).resize((14, 14), Image.LANCZOS)
    a = np.asarray(g).astype(np.float64)
    a[..., 3] = np.where(a[..., 3] > 90, 255, 0)
    out = blank(MH, MW)
    x0, y0 = int(M_EMB[0] - 7), int(M_EMB[1] - 7)
    out[y0:y0 + 14, x0:x0 + 14] = a
    return out


def mastery_bar(n, bw=78):
    img = blank(MH, MW)
    bx, by, _, bh = M_BAR
    for x in range(n):
        for y in range(bh):
            lum = 255 - y * 18
            if (x + y) % 6 == 0:
                lum = min(255, lum + 30)
            img[by + y, bx + x] = [lum, lum, lum, 255]
        img[by, bx + x] = [255, 255, 255, 255]
    if 0 < n < bw:
        img[by - 1:by + bh + 1, bx + n - 1] = [255, 255, 255, 255]
        if bx + n < bx + bw:
            img[by:by + bh, bx + n] = [255, 255, 255, 120]
    return img


def mastery_sub(n):
    img = blank(MH, MW)
    sx, sy, _, _ = M_SUB
    for x in range(min(78, n * 2)):
        img[sy, sx + x] = [255, 255, 255, 255]
    return img


def mastery_pips(k):
    img = blank(MH, MW)
    bx, by, bw, _ = M_BAR
    for m in GLYPHS["mastery"]["milestones"][:k]:
        x_ = bx + round(m * (bw - 1) / 100)
        img[by - 3, x_] = [255, 255, 255, 255]
        img[by - 2, x_ - 1:x_ + 2] = [255, 255, 255, 255]
        img[by - 4, x_] = [255, 255, 255, 110]
    return img


def mastery_digit(slot, d):
    img = blank(MH, MW)
    x0, y0 = M_DIG[0] + slot * 6, M_DIG[1]
    for y, row in enumerate(BIG[d]):
        for x, b in enumerate(row):
            if b == "1":
                img[y0 + y + 1, x0 + x + 1] = [20, 12, 24, 220]
    for y, row in enumerate(BIG[d]):
        for x, b in enumerate(row):
            if b == "1":
                lum = 255 - y * 9
                img[y0 + y, x0 + x] = [lum, lum, lum, 255]
    return img


def mastery_label(s):
    img = blank(MH, MW)
    text3(img, M_SUB[0], 24, s, (200, 190, 214))
    return img


def mastery_shine(j, n=12):
    """A soft highlight that slides along the bar, position j of n."""
    img = blank(MH, MW)
    bx, by, bw, bh = M_BAR
    yy, xx = np.mgrid[0:MH, 0:MW].astype(np.float64)
    c = bx + (j + 0.5) * bw / n
    inbar = (xx >= bx) & (xx < bx + bw) & (yy >= by) & (yy < by + bh)
    g = np.exp(-((xx - c + (yy - by) * 0.8) ** 2) / 5.0)
    over(img, (255, 255, 255), inbar * g * 0.75)
    return img


def mastery_glow():
    """Gain glow: a halo around the main bar."""
    img = blank(MH, MW)
    bx, by, bw, bh = M_BAR
    yy, xx = np.mgrid[0:MH, 0:MW].astype(np.float64)
    dx = np.maximum(np.maximum(bx - 1 - xx, xx - (bx + bw)), 0)
    dy = np.maximum(np.maximum(by - 1 - yy, yy - (by + bh)), 0)
    d = np.hypot(dx, dy)
    over(img, (255, 255, 255), ((d > 0) & (d < 3.5)) * (1 - d / 3.5) ** 1.5 * 0.8)
    return img


def mastery_flash():
    """Level-up flash: the whole dock lit, rays from the emblem."""
    img = blank(MH, MW)
    yy, xx = np.mgrid[0:MH, 0:MW].astype(np.float64)
    cx, cy = M_EMB
    r = np.hypot(xx + 0.5 - cx, yy + 0.5 - cy)
    ang = np.arctan2(yy + 0.5 - cy, xx + 0.5 - cx)
    rays = (np.cos(ang * 8) > 0.75) * np.clip(1 - r / 40, 0, 1)
    over(img, (255, 255, 255), np.clip(rays * 0.7 + smooth(16, 8, r) * 0.6, 0, 1))
    plate = (xx >= 4) & (yy >= 1) & (yy <= MH - 2)
    over(img, (255, 255, 255), plate * 0.18)
    return img


def mastery_crown():
    img = blank(MH, MW)
    cx = int(M_EMB[0])
    rows = ["1001001", "1101011", "1111111", "0111110"]
    for y, row in enumerate(rows):
        for x, b in enumerate(row):
            if b == "1":
                img[y, cx - 3 + x] = [255, 214, 90, 255] if y < 3 else [190, 140, 40, 255]
    img[0, cx] = [255, 255, 220, 255]
    return img


def hud_mastery():
    g = GLYPHS["mastery"]
    font, asc, hgt = fname(g["font"]), g["ascent"], g["height"]
    off, k = {}, int(g["base"], 16)
    for name, n in g["parts"]:
        off[name] = k
        k += n
    imgs = {"frame": [mastery_frame()], "trim": [mastery_trim()],
            "gem": [mastery_gem(m, s) for _, m, s in HEARTS], "crown": [mastery_crown()], "glow": [mastery_glow()],
            "flash": [mastery_flash()], "ring": [mastery_ring(i) for i in range(25)], "bar": [mastery_bar(i) for i in range(79)],
            "sub": [mastery_sub(i) for i in range(40)], "pips": [mastery_pips(i) for i in range(8)],
            "digit": [mastery_digit(s, d) for s in range(3) for d in range(10)],
            "label": [mastery_label(t) for t in g["labels"]], "shine": [mastery_shine(j) for j in range(12)]}
    for name, n in g["parts"]:
        assert len(imgs[name]) == n, name
        for i, img in enumerate(imgs[name]):
            font_add(font, f"gui/hud/mastery/{name}_{i}.png", asc, hgt, chr(off[name] + i), img)


def write_fonts():
    sp = {"type": "space", "advances": {cp(k): v for k, v in GLYPHS["space"]["advances"].items()}}
    names = set(FONTS) | {fname(GLYPHS["space"]["font"])}
    for name in sorted(names):
        write_json(f"assets/chaoshearts/font/{name}.json", {"providers": [sp] + FONTS.get(name, [])})


def hud():
    FONTS.clear()
    hud_hearts()
    ability_icons()
    hud_extras()
    hud_digits()
    hud_meters()
    hud_mastery()
    hud_overlays()
    write_fonts()


# =====================================================================  model helpers

ROT_OK = (-45, -22.5, 0, 22.5, 45)


def r3(p):
    return [round(float(c), 4) for c in p]


def fc(tex, uv=(0, 0, 16, 16), tint=True, rot=0):
    f = {"uv": [round(float(c), 4) for c in uv], "texture": "#" + tex}
    if tint:
        f["tintindex"] = 0
    if rot:
        f["rotation"] = rot
    return f


def el(fr, to, faces, rot=None, emit=15):
    e = {"from": r3(fr), "to": r3(to), "shade": False, "faces": faces}
    if rot:
        axis, angle = rot[0], rot[1]
        origin = rot[2] if len(rot) > 2 else (8, 8, 8)
        assert angle in ROT_OK, angle
        if angle:
            e["rotation"] = {"angle": angle, "axis": axis, "origin": r3(origin)}
    if emit:
        e["light_emission"] = emit
    return e


def box(fr, to, tex, tint=True, rot=None, faces=None, proj=False, emit=15):
    """A cuboid. tex is a texture key or a dict face->key. proj maps uvs by projection so neighbouring
    boxes share one continuous image."""
    out = {}
    names = faces or ("north", "south", "east", "west", "up", "down")
    for f in names:
        t = tex.get(f) if isinstance(tex, dict) else tex
        if t is None:
            continue
        if proj:
            x0, y0, z0 = fr
            x1, y1, z1 = to
            uv = {"south": (x0, 16 - y1, x1, 16 - y0), "north": (16 - x1, 16 - y1, 16 - x0, 16 - y0),
                  "east": (16 - z1, 16 - y1, 16 - z0, 16 - y0), "west": (z0, 16 - y1, z1, 16 - y0),
                  "up": (x0, z0, x1, z1), "down": (x0, 16 - z1, x1, 16 - z0)}[f]
            uv = tuple(min(16, max(0, c)) for c in uv)
        else:
            uv = (0, 0, 16, 16)
        out[f] = fc(t, uv, tint)
    return el(fr, to, out, rot, emit)


def plane_xz(x0, z0, x1, z1, y, tex, tint=True, rot=None, both=True, emit=15):
    f = {"up": fc(tex, (0, 0, 16, 16), tint)}
    if both:
        f["down"] = fc(tex, (0, 16, 16, 0), tint)
    return el((x0, y, z0), (x1, y, z1), f, rot, emit)


def plane_xy(x0, y0, x1, y1, z, tex, tint=True, rot=None, both=True, uv=(0, 0, 16, 16), front="south", emit=15):
    f = {front: fc(tex, uv, tint)}
    if both:
        f["north" if front == "south" else "south"] = fc(tex, uv, tint)
    return el((x0, y0, z), (x1, y1, z), f, rot, emit)


def plane_zy(z0, y0, z1, y1, x, tex, tint=True, rot=None, both=True, uv=(0, 0, 16, 16), front="east", emit=15):
    f = {front: fc(tex, uv, tint)}
    if both:
        f["west" if front == "east" else "east"] = fc(tex, uv, tint)
    return el((x, y0, z0), (x, y1, z1), f, rot, emit)


def crossed(x0, x1, y0, y1, tex, n=4, tint=True, flip_diag=True):
    """Vertical planes through the model centre at 0, 90 and (n=4) +-45 degrees."""
    out = [plane_xy(x0, y0, x1, y1, 8, tex, tint), plane_zy(x0, y0, x1, y1, 8, tex, tint)]
    if n >= 4:
        uv = (16, 0, 0, 16) if flip_diag else (0, 0, 16, 16)
        out.append(plane_xy(x0, y0, x1, y1, 8, tex, tint, ("y", 45), uv=uv))
        out.append(plane_xy(x0, y0, x1, y1, 8, tex, tint, ("y", -45), uv=uv))
    return out


def band(r, y0, y1, tex, n=16, tint=True, both=True, cx=8, cz=8):
    """A ring wall of n vertical quads at radius r (n = 4, 8 or 16)."""
    out = []
    w = 2 * r * math.tan(math.pi / n) * 1.06
    step = 360 / n
    for i in range(n):
        th = i * step
        q = int(((th + 45) % 360) // 90)
        res = ((th - q * 90 + 180) % 360) - 180
        rot = ("y", res, (cx, 8, cz)) if res else None
        if q in (0, 2):
            z = cz + r if q == 0 else cz - r
            e = plane_xy(cx - w / 2, y0, cx + w / 2, y1, z, tex, tint, rot, both, front="south" if q == 0 else "north")
        else:
            x = cx + r if q == 1 else cx - r
            e = plane_zy(cz - w / 2, y0, cz + w / 2, y1, x, tex, tint, rot, both, front="east" if q == 1 else "west")
        if rot:
            e["rotation"]["origin"] = r3((cx, 8, cz))
        out.append(e)
    return out


def model(name, textures, elements, display=None, gui_light=None):
    tex = {k: v for k, v in textures.items()}
    tex.setdefault("particle", next(iter(textures.values())))
    m = {"textures": tex, "elements": elements}
    if gui_light:
        m["gui_light"] = gui_light
    m["display"] = display or {
        "gui": {"rotation": [30, 225, 0], "translation": [0, 0, 0], "scale": [0.6, 0.6, 0.6]},
        "ground": {"rotation": [0, 0, 0], "translation": [0, 3, 0], "scale": [0.4, 0.4, 0.4]},
        "fixed": {"rotation": [0, 0, 0], "translation": [0, 0, 0], "scale": [0.6, 0.6, 0.6]},
        "thirdperson_righthand": {"rotation": [75, 45, 0], "translation": [0, 2.5, 0], "scale": [0.375, 0.375, 0.375]},
        "firstperson_righthand": {"rotation": [0, 45, 0], "translation": [0, 0, 0], "scale": [0.4, 0.4, 0.4]},
        "head": {"rotation": [0, 0, 0], "translation": [0, 0, 0], "scale": [1, 1, 1]},
    }
    write_json(f"assets/chaoshearts/models/item/{name}.json", m)


ITEM_DEFS = {}


def item_def(name, tints=None, model_id=None):
    m = {"type": "minecraft:model", "model": model_id or f"chaoshearts:item/{name}"}
    if tints is not None:
        m["tints"] = [{"type": "minecraft:custom_model_data", "index": 0, "default": tints}]
    ITEM_DEFS[name] = {"model": m}


def write_item_defs():
    for name, d in ITEM_DEFS.items():
        write_json(f"assets/chaoshearts/items/{name}.json", d)


# =====================================================================  FX textures

def gtex(alpha, lum=1.0):
    h, w = alpha.shape
    img = blank(h, w)
    img[..., :3] = np.clip(np.broadcast_to(np.asarray(lum, dtype=np.float64), (h, w)) * 255, 0, 255)[..., None]
    img[..., 3] = np.clip(alpha, 0, 1) * 255
    return img


def art_to_grey(A):
    """White-on-transparent art (colour discarded into luminance)."""
    img = A.img.copy()
    lum = img[..., :3].mean(axis=2)
    img[..., :3] = lum[..., None]
    return img


def rune_glyph(A, cx, cy, size, rng, col=(255, 255, 255), w=1.4):
    """A random angular rune made of 2-4 strokes on a 3x3 lattice."""
    pts = [(cx + (i % 3 - 1) * size / 2, cy + (i // 3 - 1) * size / 2) for i in range(9)]
    for _ in range(int(rng.integers(2, 5))):
        a, b = rng.choice(9, 2, replace=False)
        A.line([pts[a], pts[b]], w, col)
    if rng.random() < 0.5:
        A.circle(*pts[int(rng.integers(0, 9))], w * 0.9, col)


def rune_circle_frames(S, nframes, seed, glyphs=16, inner_sym=6):
    """Frames of a rotating rune circle: the glyph ring turns once over the loop, the inner sigil
    turns backwards by one symmetry step (so the loop is seamless)."""
    rng0 = np.random.default_rng(seed)
    gl_seeds = [int(rng0.integers(0, 1 << 30)) for _ in range(glyphs)]
    frames = []
    c = S / 2
    for f in range(nframes):
        ph = f / nframes
        A = Art(S, S, 3)
        A.ring(c, c, S * 0.47, S * 0.018, (255, 255, 255))
        A.ring(c, c, S * 0.47, S * 0.05, (255, 255, 255), 0.3, blur=S * 0.01)
        A.ring(c, c, S * 0.35, S * 0.014, (255, 255, 255))
        for k in range(glyphs):
            a = 2 * math.pi * (k / glyphs + ph)
            gx, gy = c + math.cos(a) * S * 0.41, c + math.sin(a) * S * 0.41
            rune_glyph(A, gx, gy, S * 0.07, np.random.default_rng(gl_seeds[k]), w=max(1.0, S * 0.012))
        rot = -360.0 / inner_sym * ph
        n = inner_sym
        tri1 = [(c + S * 0.33 * math.cos(math.radians(rot + 90 + k * 360 / n * 2)), c + S * 0.33 * math.sin(math.radians(rot + 90 + k * 360 / n * 2))) for k in range(n // 2 + 1)]
        tri2 = [(c + S * 0.33 * math.cos(math.radians(rot + 90 + 360 / n + k * 360 / n * 2)), c + S * 0.33 * math.sin(math.radians(rot + 90 + 360 / n + k * 360 / n * 2))) for k in range(n // 2 + 1)]
        A.line(tri1, S * 0.012, (255, 255, 255), 0.9).line(tri2, S * 0.012, (255, 255, 255), 0.9)
        A.ring(c, c, S * 0.17, S * 0.012, (255, 255, 255), 0.9)
        for k in range(n):
            a = math.radians(rot + k * 360 / n)
            A.circle(c + math.cos(a) * S * 0.25, c + math.sin(a) * S * 0.25, S * 0.018, (255, 255, 255))
        A.circle(c, c, S * 0.05, (255, 255, 255), 0.8, blur=S * 0.02)
        g = art_to_grey(A)
        x, y, r, _ = polar(S, S)
        over(g, (255, 255, 255), gauss(r - 0.94, 0.08) * 0.25)
        frames.append(g)
    return frames


def bolt_frames(S, n, seed):
    rng = np.random.default_rng(seed)
    frames = []
    for f in range(n):
        A = Art(S, S, 2)
        main = jag((S / 2 + rng.normal(0, S * 0.08), 0), (S / 2 + rng.normal(0, S * 0.08), S), 12, S * 0.06, rng)
        br = []
        for _ in range(3):
            j = int(rng.integers(2, 10))
            q = main[j]
            br.append(jag(q, (q[0] + rng.normal(0, S * 0.3), q[1] + rng.uniform(S * 0.1, S * 0.35)), 5, S * 0.03, rng))
        dim = 0.45 if f % 4 == 3 else 1.0
        A.line(main, S * 0.12, (255, 255, 255), 0.35 * dim, blur=S * 0.04)
        for b in br:
            A.line(b, S * 0.03, (255, 255, 255), 0.7 * dim)
        A.line(main, S * 0.045, (255, 255, 255), dim)
        frames.append(art_to_grey(A))
    return frames


def flame_frames(S, n, seed, core=False):
    rng = np.random.default_rng(seed)
    nz = pnoise(S * 2, S, rng, 1.7, (1.0, 0.6))
    nz2 = pnoise(S * 2, S, rng, 1.2)
    u, v = uv_grid(S, S)
    frames = []
    for f in range(n):
        off = int(f * 2 * S / n)
        a1 = np.roll(nz, -off, axis=0)[:S]
        a2 = np.roll(nz2, -off // 2, axis=0)[:S]
        hgt = 1 - v
        width = (0.36 if not core else 0.22) * (1 - hgt ** 1.6) + 0.02
        d = np.abs(u - 0.5 + 0.05 * (a2 - 0.5) * hgt * 4) - width
        body = smooth(0.08, -0.06, d + (a1 - 0.5) * 0.28 * hgt)
        body *= smooth(0.0, 0.05, v)
        lum = 0.55 + 0.45 * smooth(0.6, 0.0, np.abs(u - 0.5) / (width + 0.01) * 0.6 + hgt * 0.8)
        frames.append(gtex(body * (0.95 if not core else 1.0), lum))
    return frames


def fx_textures():
    S = 64
    x, y, r, ang = polar(S, S)
    u, v = uv_grid(S, S)
    rng = np.random.default_rng(404)
    angn = pnoise(1, 64, rng, 1.0)[0]
    ai = ((ang + math.pi) / (2 * math.pi) * 63).astype(int)
    T = "item/fx/"
    save_png(T + "ring", gtex(np.clip(gauss(r - 0.86, 0.05) + 0.5 * gauss(r - 0.86, 0.16), 0, 1) * (0.8 + 0.2 * angn[ai]) * smooth(1.0, 0.97, r),
                              1 - 0.12 * gauss(r - 0.86, 0.2)))
    streak = pnoise(64, 64, rng, 1.0, (1.0, 0.1))
    save_png(T + "ring_band", gtex((1 - v) ** 1.6 * (0.7 + 0.3 * streak) + gauss(v - 0.97, 0.04) * 0.6))
    save_png(T + "ring_soft", gtex(0.8 * gauss(r - 0.7, 0.2) * smooth(1.0, 0.9, r)))
    save_png(T + "ring_soft_band", gtex((1 - v) ** 2.2 * 0.55 * (0.8 + 0.2 * streak)))
    save_png(T + "disc", gtex(smooth(1.0, 0.9, r) * (0.3 + 0.45 * (1 - r)) + 0.55 * gauss(r - 0.92, 0.05) * smooth(1.0, 0.97, r)))
    # hex lattice used by dome, hex and cube
    def hexlines(sz, k, wdt):
        """Edges of a pointy-top hex lattice with k cells across (1 on the edges)."""
        X, Y = (u - 0.5) * k, (v - 0.5) * k
        h3 = math.sqrt(3)

        def hexd(px, py):
            px, py = np.abs(px), np.abs(py)
            return np.maximum(px, px * 0.5 + py * h3 / 2)
        da = hexd(np.mod(X, 1) - 0.5, np.mod(Y, h3) - h3 / 2)
        db = hexd(np.mod(X - 0.5, 1) - 0.5, np.mod(Y - h3 / 2, h3) - h3 / 2)
        return smooth(0.5 - wdt, 0.5, np.minimum(da, db))
    hl = hexlines(S, 6, 0.08)
    save_png(T + "dome", gtex(0.16 + 0.7 * hl, 0.85 + 0.15 * hl))
    save_png(T + "dome_cap", gtex((0.16 + 0.7 * hl) * smooth(1.0, 0.9, r)))
    # slash: a crescent on the +Z half (texture bottom), thickest straight ahead
    th = np.arctan2(y, x)  # +Z is +y in texture
    front = np.clip(np.sin(th), 0, 1)
    outer = 0.92
    thick = 0.42 * front ** 1.4
    inside = (r < outer) & (r > outer - thick) & (y > 0)
    t = np.clip((outer - r) / np.maximum(thick, 1e-3), 0, 1)
    sl = inside * (1 - t) ** 0.8 * smooth(0.0, 0.25, front)
    save_png(T + "slash", gtex(sl + gauss(r - outer, 0.025) * front ** 2 * 0.9, 0.85 + 0.15 * (1 - t)))
    save_png(T + "slash_glow", gtex(gauss(r - outer + 0.1, 0.16) * front ** 2 * (y > -0.1) * 0.55))
    # beam: animated scrolling energy
    bn = pnoise(128, 64, rng, 1.0, (1.0, 0.2))
    frames = []
    for f in range(8):
        n_ = np.roll(bn, f * 16, axis=0)[:64]
        a = (gauss(u - 0.5, 0.1) + gauss(u - 0.5, 0.32) * 0.45 * (0.6 + 0.4 * n_)) * smooth(0.0, 0.18, v)
        frames.append(gtex(a, 0.9 + 0.1 * n_))
    save_texture(T + "beam", frames, 1)
    save_png(T + "beam_core", gtex(0.92 + 0.0 * u, 0.92 + 0.08 * np.sin(v * 40)))
    save_png(T + "orb_core", gtex(np.ones_like(r), 1 - 0.22 * np.clip(r, 0, 1) ** 2))
    save_png(T + "orb_glow", gtex(gauss(r, 0.5) * 0.85 * smooth(1.0, 0.85, r)))
    # crystal facets (shard, altar)
    pts = rng.uniform(0, 1, (9, 2))
    dd = np.stack([np.hypot(u - px, v - py) for px, py in pts])
    cell = np.argmin(dd, axis=0)
    srt = np.sort(dd, axis=0)
    edge = smooth(0.03, 0.0, srt[1] - srt[0])
    flum = 0.62 + 0.38 * (cell * 0.37 % 1)
    save_png(T + "shard", gtex(0.82 + 0.18 * edge, np.clip(flum + 0.4 * edge, 0, 1)))
    save_png(T + "shard_plane", gtex(smooth(1.0, 0.9, np.abs(x) * 2.6 + np.abs(y)) * 0.55 + gauss(x, 0.05) * smooth(1, 0.6, np.abs(y)) * 0.4))
    # spike: a triangle pointing up
    half = 0.5 * v
    sp = smooth(0.03, -0.02, np.abs(u - 0.5) - half)
    save_png(T + "spike", gtex(sp, 0.7 + 0.3 * gauss(u - 0.5 - 0.1 * v, 0.08 + 0.1 * v)))
    save_png(T + "spike_core", gtex(np.ones_like(u), 0.8 + 0.2 * (1 - v)))
    save_texture(T + "rune", rune_circle_frames(64, 32, 77, 12, 4), 2)
    save_png(T + "rune_glow", gtex(gauss(r - 0.7, 0.28) * 0.35 * smooth(1.0, 0.9, r)))
    save_texture(T + "bolt", bolt_frames(64, 8, 9), 1)
    save_texture(T + "flame", flame_frames(64, 16, 31), 1)
    save_texture(T + "flame_core", flame_frames(32, 16, 32, core=True), 1)
    # swirl: three spiral arms, turning one arm step over the loop
    frames = []
    for f in range(16):
        ph = f / 16 * 2 * math.pi / 3
        s_ = np.sin(3 * (ang - ph) + 5.5 * r)
        a = smooth(0.2, 1.0, s_) * smooth(1.0, 0.75, r) * smooth(0.05, 0.25, r)
        frames.append(gtex(a * 0.9 + gauss(r, 0.18) * 0.4))
    save_texture(T + "swirl", frames, 1)
    wn = pnoise(128, 64, rng, 1.4, (0.4, 1.0))
    frames = []
    for f in range(8):
        n_ = np.roll(wn, f * 16, axis=0)[:64]
        a = smooth(0.55, 0.85, n_) * smooth(0.5, 0.2, np.abs(u - 0.5)) * smooth(0, 0.2, v) * smooth(1, 0.8, v)
        frames.append(gtex(a * 0.8))
    save_texture(T + "swirl_wisp", frames, 2)
    st = np.exp(-np.abs(x) * 16) * np.exp(-np.abs(y) * 2.4) + np.exp(-np.abs(y) * 16) * np.exp(-np.abs(x) * 2.4) + gauss(r, 0.2)
    save_png(T + "star", gtex(np.clip(st, 0, 1) * smooth(1.0, 0.85, r)))
    # crack: branching fissure from the centre
    A = Art(S, S, 3)
    cr = []
    r2 = np.random.default_rng(12)
    for k in range(7):
        a = k * 2 * math.pi / 7 + r2.normal(0, 0.25)
        p = (S / 2, S / 2)
        w = 2.6
        for _ in range(6):
            a += r2.normal(0, 0.45)
            q = (p[0] + math.cos(a) * S * 0.07, p[1] + math.sin(a) * S * 0.07)
            cr.append(([p, q], w))
            if r2.random() < 0.3:
                b = a + r2.choice([-1, 1]) * 0.9
                cr.append(([q, (q[0] + math.cos(b) * S * 0.08, q[1] + math.sin(b) * S * 0.08)], w * 0.5))
            p = q
            w *= 0.82
    A.lines([(p_, w * 3) for p_, w in cr], (255, 255, 255), 0.35, blur=1.5)
    A.lines(cr, (255, 255, 255), 1.0)
    crack = art_to_grey(A)
    crack[..., 3] *= smooth(1.0, 0.85, r)
    save_png(T + "crack", crack)
    save_png(T + "crack_glow", gtex(gauss(r, 0.45) * 0.3))
    hexd = np.maximum.reduce([np.abs(x), np.abs(x * 0.5 + y * 0.866), np.abs(x * 0.5 - y * 0.866)])
    save_png(T + "hex", gtex(np.clip(gauss(hexd - 0.86, 0.04) + 0.35 * gauss(hexd - 0.86, 0.15) + (hexd < 0.86) * (0.12 + 0.5 * hexlines(S, 9, 0.06)), 0, 1) * smooth(0.98, 0.92, hexd)))
    de = np.minimum.reduce([u, 1 - u, v, 1 - v])
    save_png(T + "cube", gtex(0.18 + 0.82 * smooth(0.12, 0.0, de), 0.85 + 0.15 * smooth(0.12, 0.0, de)))
    save_png(T + "cube_core", gtex(0.75 + 0.0 * u, 1 - 0.2 * np.hypot(u - 0.5, v - 0.5)))
    # skull: 16px bone pixel art (greyscale so it tints)
    face = ["................",
            ".bbbbbbbbbbbbbb.",
            ".bBBBBBBBBBBBBb.",
            ".bBBBBBBBBBBBBb.",
            ".bBBBBBBBBBBBBb.",
            ".bBkkkkBBkkkkBb.",
            ".bBkKKkBBkKKkBb.",
            ".bBkKKkBBkKKkBb.",
            ".bBkkkkBBkkkkBb.",
            ".bBBBBBBBBBBBBb.",
            ".bBBBBBkkBBBBBb.",
            ".bBBBBkkkkBBBBb.",
            ".bBBBBBBBBBBBBb.",
            ".bbBBBBBBBBBBbb.",
            "..bbbbbbbbbbbb..",
            "................"]
    jaw = ["................",
           ".bbbbbbbbbbbbbb.",
           ".bWkWkWkWkWkWkb.",
           ".bWkWkWkWkWkWkb.",
           ".bBBBBBBBBBBBBb.",
           ".bBBBBBBBBBBBBb.",
           ".bbBBBBBBBBBBbb.",
           "..bbbbbbbbbbbb..",
           "................"] + ["................"] * 7
    pal = {"b": (150, 1), "B": (225, 1), "k": (40, 1), "K": (8, 1), "W": (250, 1), ".": (0, 0)}

    def pix(rows):
        img = blank(16, 16)
        for yy, row in enumerate(rows):
            for xx, ch in enumerate(row):
                l, a = pal[ch]
                img[yy, xx] = [l, l, l, 255 * a]
        return img
    save_png(T + "skull_face", pix(face))
    save_png(T + "skull_jaw", pix(jaw))
    side = blank(16, 16)
    side[..., :3] = (205 + rng.normal(0, 10, (16, 16)))[..., None]
    side[..., 3] = 255
    save_png(T + "skull_side", side)
    # cloud: drifting puffs
    cn = pnoise(32, 32, rng, 1.6)
    cu, cv = uv_grid(32, 32)
    cr_ = np.hypot(cu - 0.5, cv - 0.5)
    frames = []
    for f in range(8):
        n_ = np.roll(np.roll(cn, f * 4, axis=1), f * 2, axis=0)
        frames.append(gtex(smooth(0.3, 0.7, n_) * smooth(0.7, 0.3, cr_) * 0.85 + smooth(0.6, 0.2, cr_) * 0.25, 0.78 + 0.22 * n_))
    save_texture(T + "cloud", frames, 3)
    # feather
    A = Art(32, 32, 4)
    shaft = bez((16, 31), (17.5, 16), (15, 2), 20)
    for i, (px, py) in enumerate(shaft[2:-1]):
        t_ = i / 17
        wv = 9 * math.sin(math.pi * (0.15 + 0.85 * t_)) ** 0.7
        A.line([(px, py), (px - wv, py - 3.2)], 1.6, (235, 235, 235))
        A.line([(px, py), (px + wv, py - 3.0)], 1.6, (255, 255, 255))
    A.line(shaft, 1.2, (200, 200, 200))
    save_png(T + "feather", art_to_grey(A))


# =====================================================================  FX models

FX = ["ring", "ring_soft", "disc", "dome", "slash", "beam", "orb", "shard", "spike", "rune", "bolt", "flame",
      "swirl", "star", "crack", "hex", "cube", "skull", "cloud", "feather"]


def fx_models():
    P = "chaoshearts:item/fx/"
    for name in FX:
        tx = {}
        E = []

        def t(key, tex=None):
            tx[key] = P + (tex or key)
            return key

        if name == "ring":
            E += [plane_xz(0, 0, 16, 16, 8, t("ring"))]
            E += band(6.9, 8, 9.6, t("ring_band"))
        elif name == "ring_soft":
            E += [plane_xz(0, 0, 16, 16, 8, t("ring_soft"))]
            E += band(5.6, 8, 11.5, t("ring_soft_band"))
        elif name == "disc":
            E += [plane_xz(0, 0, 16, 16, 8, t("disc")), plane_xz(3, 3, 13, 13, 8.04, t("orb_glow"))]
        elif name == "dome":
            angs = [0, 15, 30, 45, 60, 75]
            for a0, a1 in zip(angs, angs[1:]):
                y0, y1 = 8 + 8 * math.sin(math.radians(a0)), 8 + 8 * math.sin(math.radians(a1))
                rr = 8 * math.cos(math.radians((a0 + a1) / 2))
                E += band(rr, y0, y1, t("dome"))
            cap = 8 * math.cos(math.radians(75))
            E += [plane_xz(8 - cap, 8 - cap, 8 + cap, 8 + cap, 8 + 8 * math.sin(math.radians(75)), t("dome_cap")),
                  plane_xz(0, 0, 16, 16, 8.02, t("ring"))]
        elif name == "slash":
            E += [plane_xz(0, 0, 16, 16, 8, t("slash")), plane_xz(0, 0, 16, 16, 8.15, t("slash_glow")),
                  plane_xz(1, 1, 15, 15, 7.85, t("slash_glow"))]
        elif name == "beam":
            E += crossed(0, 16, 8, 24, t("beam"))
            E += [box((6.5, 8, 6.5), (9.5, 24, 9.5), t("beam_core"), faces=("north", "south", "east", "west"))]
        elif name == "orb":
            c = t("orb_core")
            E += [box((5, 5, 5), (11, 11, 11), c), box((4, 6, 6), (12, 10, 10), c), box((6, 4, 6), (10, 12, 10), c),
                  box((6, 6, 4), (10, 10, 12), c)]
            g = t("orb_glow")
            E += [plane_xy(0, 0, 16, 16, 8, g), plane_xz(0, 0, 16, 16, 8, g), plane_zy(0, 0, 16, 16, 8, g),
                  plane_xy(0, 0, 16, 16, 8, g, rot=("y", 45)), plane_xy(0, 0, 16, 16, 8, g, rot=("y", -45))]
        elif name == "shard":
            s_ = t("shard")
            E += [box((6, 3, 6), (10, 13, 10), s_, rot=("y", 45)), box((6.6, 1.2, 6.6), (9.4, 14.8, 9.4), s_, rot=("y", 45)),
                  box((7.3, 0, 7.3), (8.7, 16, 8.7), s_, rot=("y", 45)), box((6.4, 2, 6.4), (9.6, 14, 9.6), s_, rot=("y", 22.5))]
            E += crossed(3, 13, 0, 16, t("shard_plane"), n=2)
        elif name == "spike":
            E += crossed(4, 12, 8, 24, t("spike"))
            c = t("spike_core")
            E += [box((6.5, 8, 6.5), (9.5, 13, 9.5), c, rot=("y", 45)), box((7, 13, 7), (9, 18, 9), c, rot=("y", 45)),
                  box((7.5, 18, 7.5), (8.5, 22, 8.5), c, rot=("y", 45))]
        elif name == "rune":
            E += [plane_xz(0, 0, 16, 16, 8, t("rune")), plane_xz(0, 0, 16, 16, 8.04, t("rune_glow"))]
        elif name == "bolt":
            E += crossed(0, 16, 0, 16, t("bolt"))
        elif name == "flame":
            E += crossed(0, 16, 8, 24, t("flame"))
            E += crossed(3, 13, 8, 19, t("flame_core"), n=2)
        elif name == "swirl":
            s_ = t("swirl")
            E += [plane_xz(3, 3, 13, 13, 3, s_), plane_xz(0, 0, 16, 16, 8, s_), plane_xz(1.5, 1.5, 14.5, 14.5, 12.5, s_)]
            E += crossed(1, 15, 0, 16, t("swirl_wisp"))
        elif name == "star":
            E += [plane_xz(0, 0, 16, 16, 8, t("star")), plane_xz(3, 3, 13, 13, 8.03, t("star"), rot=("y", 45))]
        elif name == "crack":
            E += [plane_xz(0, 0, 16, 16, 8, t("crack")), plane_xz(2, 2, 14, 14, 8.03, t("crack_glow"))]
        elif name == "hex":
            E += [plane_xz(0, 0, 16, 16, 8, t("hex")), plane_xz(1, 1, 15, 15, 8.03, t("orb_glow"))]
        elif name == "cube":
            E += [box((2, 2, 2), (14, 14, 14), t("cube")), box((5, 5, 5), (11, 11, 11), t("cube_core")),
                  box((5, 5, 5), (11, 11, 11), t("cube_core"), rot=("y", 45))]
        elif name == "skull":
            face, side, jaw = t("skull_face"), t("skull_side"), t("skull_jaw")
            E += [box((3.5, 6, 3.5), (12.5, 14, 12.5), {"south": face, "north": side, "east": side, "west": side, "up": side, "down": side}),
                  box((4.5, 3, 4.5), (11.5, 6, 11.5), {"south": jaw, "north": side, "east": side, "west": side, "down": side})]
        elif name == "cloud":
            c = t("cloud")
            E += [box((2, 5, 4), (10, 11, 12), c), box((6, 4, 3), (14, 10, 11), c), box((4, 7, 5), (12, 13, 12), c, rot=("y", 45)),
                  box((1, 6, 6), (7, 10, 10), c), box((9, 6, 6), (15, 10, 11), c), box((5, 3, 5), (11, 7, 11), c, rot=("y", 22.5))]
        elif name == "feather":
            f_ = t("feather")
            E += [plane_xy(2, 0, 14, 16, 8, f_), plane_zy(2, 0, 14, 16, 8, f_)]
        model(f"fx/{name}", tx, E)
        item_def(f"fx/{name}", 16777215)


# =====================================================================  the Eye

def eye_textures():
    T = "item/eye/"
    rng = np.random.default_rng(66)
    S = 64
    x, y, r, ang = polar(S, S)
    ivory = np.array([228, 216, 198.0])
    n = pnoise(S, S, rng, 1.5)
    col = ivory[None, None] * (0.92 + 0.12 * n[..., None])
    pink = np.array([196, 96, 98.0])
    col = col * (1 - smooth(0.45, 1.0, r)[..., None] * 0.55) + pink * smooth(0.45, 1.0, r)[..., None] * 0.55
    col *= (1 - 0.45 * smooth(0.55, 1.05, r))[..., None]
    img = blank(S, S)
    img[..., :3] = col
    img[..., 3] = 255
    A = Art(S, S, 3)
    A.img = img

    def vstart(rg):
        a = rg.uniform(0, 2 * math.pi)
        return S / 2 + math.cos(a) * S * 0.52, S / 2 + math.sin(a) * S * 0.52, a + math.pi + rg.normal(0, 0.3)
    vs = walks(rng, 26, vstart, 9, S * 0.03, 0.4, 0.25, 1.3, 2)
    A.lines([(p, w * 1.8) for p, w in vs], (170, 40, 50), 0.4, blur=0.6)
    A.lines(vs, (140, 14, 26), 0.95)
    save_png(T + "sclera_front", A.img)
    side = blank(32, 32)
    side[..., :3] = (ivory * 0.8)[None, None] * (0.9 + 0.15 * pnoise(32, 32, rng, 1.5)[..., None])
    side[..., 3] = 255
    B = Art(32, 32, 3)
    B.img = side
    vs = walks(rng, 10, lambda rg: (rg.uniform(0, 32), rg.uniform(0, 32), rg.uniform(0, 6.28)), 8, 1.6, 0.5, 0.2, 0.9, 1)
    B.lines(vs, (130, 20, 30), 0.85)
    save_png(T + "sclera_side", B.img)
    # dark scaly lid flesh
    lid = blank(32, 32)
    u, v = uv_grid(32, 32)
    lid[..., :3] = np.array([46, 22, 36.0])
    lid[..., 3] = 255
    for row in range(9):
        for k in range(9):
            cx = k * 4 + (2 if row % 2 else 0)
            cy = row * 4
            d = np.hypot(u * 32 - cx, (v * 32 - cy) * 1.2)
            sc = d < 2.6
            hl = smooth(2.6, 0.5, d) * (v * 32 < cy)
            lid[sc, :3] = (np.array([60, 30, 48.0]) + hl[sc][:, None] * np.array([40, 22, 32.0]))
            rim = (d >= 2.6) & (d < 3.0)
            lid[rim, :3] = [20, 8, 14]
    lid[..., :3] *= (0.9 + 0.2 * pnoise(32, 32, rng, 1.4))[..., None]
    save_png(T + "lid", lid)
    rim = blank(32, 32)
    rim[..., :3] = mixc((110, 22, 36), (170, 50, 64), pnoise(32, 32, rng, 1.2)[..., None])
    rim[..., 3] = 255
    over(rim, (240, 170, 180), smooth(0.8, 0.95, pnoise(32, 32, rng, 0.8, (1, 0.2))) * 0.7)
    save_png(T + "lid_rim", rim)
    dark = blank(64, 64)
    over(dark, (4, 0, 8), smooth(1.0, 0.45, r))
    save_png(T + "darkness", dark)
    sock = blank(64, 64)
    over(sock, mixc((10, 2, 14), (40, 6, 20), pnoise(64, 64, rng, 1.5)[..., None]), smooth(0.43, 0.5, r) * smooth(1.0, 0.8, r))
    save_png(T + "socket", sock)
    gl = blank(16, 16)
    gx, gy, gr, _ = polar(16, 16)
    over(gl, (255, 255, 255), smooth(1.0, 0.3, gr) * 0.85)
    save_png(T + "glint", gl)
    # iris: violet and amber, swirling, with a slit pupil that breathes
    frames = []
    swirl_n = pnoise(64, 64, rng, 1.0, (1.0, 0.15))
    for f in range(16):
        ph = f / 16
        a2 = ang + 0.9 * r + ph * 2 * math.pi / 6
        fib = 0.5 + 0.5 * np.sin(a2 * 24 + 6 * r)
        fib2 = 0.5 + 0.5 * np.sin(a2 * 7 - 4 * r + ph * 2 * math.pi)
        amber = np.array([255, 176, 40.0])
        violet = np.array([140, 40, 230.0])
        deep = np.array([40, 0, 60.0])
        t1 = smooth(0.15, 0.55, r)[..., None]
        t2 = smooth(0.6, 0.98, r)[..., None]
        c = amber * (1 - t1) + violet * t1
        c = c * (1 - t2) + deep * t2
        c *= (0.62 + 0.38 * fib[..., None]) * (0.85 + 0.25 * fib2[..., None])
        ii = int(f * 4) % 64
        c *= (0.9 + 0.2 * np.roll(swirl_n, ii, axis=1)[..., None])
        img = blank(S, S)
        img[..., :3] = np.clip(c, 0, 255)
        img[..., 3] = smooth(1.0, 0.95, r) * 255
        wpx = 0.12 * (0.8 + 0.2 * math.sin(ph * 2 * math.pi))
        slit = np.abs(x) < wpx * np.sqrt(np.clip(1 - (y / 0.8) ** 2, 0, 1))
        glow = gauss(np.abs(x) - wpx * np.sqrt(np.clip(1 - (y / 0.8) ** 2, 0, 1)), 0.06) * (np.abs(y) < 0.85)
        over(img, (255, 60, 30), glow * 0.6 * (r < 0.95))
        img[slit & (r < 0.95), :3] = [3, 0, 6]
        frames.append(img)
    save_texture(T + "iris", frames, 2)
    cor = blank(64, 64)
    over(cor, (255, 255, 255), gauss(r - 0.9, 0.06) * 0.22 + gauss(np.hypot(x + 0.35, y + 0.4), 0.18) * 0.35)
    save_png(T + "cornea", cor)
    # smoky shroud
    sn = pnoise(32, 32, rng, 1.5)
    su, sv = uv_grid(32, 32)
    sr = np.hypot(su - 0.5, sv - 0.5) * 2
    de = np.minimum.reduce([su, 1 - su, sv, 1 - sv])
    for nm, hole in (("shroud", False), ("shroud_front", True)):
        frames = []
        for f in range(8):
            n_ = np.roll(np.roll(sn, f * 4, axis=0), f * 2, axis=1)
            img = blank(32, 32)
            img[..., :3] = mixc((10, 2, 18), (48, 14, 70), n_[..., None])
            a = (0.3 + 0.55 * n_) * smooth(0.0, 0.22, de)
            if hole:
                a *= smooth(0.45, 0.85, sr)
            img[..., 3] = a * 255
            frames.append(img)
        save_texture(T + nm, frames, 3)
    # tendril: writhing shadow, 16x48 frames
    frames = []
    for f in range(12):
        ph = f / 12 * 2 * math.pi
        A = Art(16, 48, 4)
        pts = []
        for k in range(25):
            t_ = k / 24
            yy = 48 - t_ * 47
            xx = 8 + (1.2 + 4.2 * t_) * math.sin(ph + t_ * 5.5) * t_ ** 0.6
            pts.append((xx, yy))
        for k in range(len(pts) - 1):
            t_ = k / 24
            w = 4.6 * (1 - t_) ** 0.9 + 0.4
            A.line([pts[k], pts[k + 1]], w + 1.6, (120, 40, 190), 0.5, blur=0.6)
            A.line([pts[k], pts[k + 1]], w, (14, 2, 22))
        for k in range(3, 20, 4):
            px, py = pts[k]
            A.circle(px + 0.8, py, 0.6, (190, 90, 255), 0.8)
        frames.append(A.img)
    save_texture(T + "tendril", frames, 2)
    full = os.path.join(PACK, "assets", "chaoshearts", "textures", T + "tendril.png.mcmeta")
    with open(full, "w") as fh:
        json.dump({"animation": {"frametime": 2, "interpolate": True, "width": 16, "height": 48}}, fh, indent=2)


def eye_models():
    P = "chaoshearts:item/eye/"
    tx = {"front": P + "sclera_front", "side": P + "sclera_side", "lid": P + "lid", "rim": P + "lid_rim",
          "dark": P + "darkness", "socket": P + "socket", "glint": P + "glint", "particle": P + "sclera_side"}
    E = []
    sc = {"south": "front", "north": "side", "east": "side", "west": "side", "up": "side", "down": "side"}
    R = 7.0
    for y0, y1 in ((-7, -5.5), (-5.5, -3.5), (-3.5, -1.5), (-1.5, 1.5), (1.5, 3.5), (3.5, 5.5), (5.5, 7)):
        mid = (y0 + y1) / 2
        w = math.sqrt(max(R * R - mid * mid, 1)) * 0.985
        for rot in (0, 22.5, 45, -22.5):
            E.append(box((8 - w, 8 + y0, 8 - w), (8 + w, 8 + y1, 8 + w), sc, tint=False, rot=("y", rot) if rot else None, proj=True, emit=0))
    lidf = {"south": "lid", "east": "lid", "west": "lid", "up": "lid", "north": "lid", "down": "rim"}
    lowf = {"south": "lid", "east": "lid", "west": "lid", "down": "lid", "north": "lid", "up": "rim"}
    for rot in (0, 22.5, -22.5, 45, -45):
        rr = ("y", rot) if rot else None
        E.append(box((2.4, 11.6, 9), (13.6, 15.6, 16.6), lidf, False, rr, emit=0))
        E.append(box((2.8, 0.6, 9), (13.2, 4.2, 16.3), lowf, False, rr, emit=0))
    E.append(box((3.6, 13.2, 5), (12.4, 16.6, 15.4), lidf, False, ("x", -22.5), emit=0))
    E.append(box((3.8, -0.4, 6), (12.2, 2.6, 15.0), lowf, False, ("x", 22.5), emit=0))
    E.append(plane_xy(-8, -8, 24, 24, 9.5, "socket", False, front="south", both=False, emit=0))
    E.append(plane_xy(-16, -16, 32, 32, 1, "dark", False, front="south", both=True, emit=0))
    E.append(plane_xy(4.4, 8.8, 6.6, 11.0, 15.95, "glint", False, front="south", both=False))
    model("the_eye", tx, E, display=eye_display(0.5))
    item_def("the_eye")

    tx = {"iris": P + "iris", "cornea": P + "cornea", "particle": P + "iris"}
    E = [plane_xy(3.5, 3.5, 12.5, 12.5, 15.4, "iris", False, front="south", both=False),
         plane_xy(3.1, 3.1, 12.9, 12.9, 15.75, "cornea", False, front="south", both=False)]
    model("eye_pupil", tx, E, display=eye_display(0.6))
    item_def("eye_pupil")

    tx = {"s": P + "shroud", "f": P + "shroud_front", "particle": P + "shroud"}
    sh = {"south": "f", "north": "s", "east": "s", "west": "s", "up": "s", "down": "s"}
    E = [box((-3, -3, -3), (19, 19, 19), sh, False, emit=0),
         box((-1, -1, -1), (17, 17, 17), "f", False, ("y", 45), emit=0),
         box((0, -2, 0), (16, 18, 16), "f", False, ("x", 45), emit=0)]
    model("eye_shroud", tx, E, display=eye_display(0.35))
    item_def("eye_shroud")

    tx = {"t": P + "tendril", "particle": P + "tendril"}
    E = [plane_xy(4, 8, 12, 32, 8, "t", False, emit=0), plane_zy(4, 8, 12, 32, 8, "t", False, emit=0),
         plane_xy(4, 8, 12, 32, 8, "t", False, ("y", 45), emit=0),
         plane_xy(4, 8, 12, 32, 8, "t", False, ("y", -45), emit=0)]
    model("eye_tendril", tx, E, display=eye_display(0.4))
    item_def("eye_tendril")


def eye_display(gs):
    return {"gui": {"rotation": [0, 180, 0], "translation": [0, 0, 0], "scale": [gs, gs, gs]},
            "fixed": {"rotation": [0, 180, 0], "translation": [0, 0, 0], "scale": [gs, gs, gs]},
            "ground": {"rotation": [0, 0, 0], "translation": [0, 3, 0], "scale": [0.3, 0.3, 0.3]},
            "head": {"rotation": [0, 0, 0], "translation": [0, 0, 0], "scale": [1, 1, 1]}}


# =====================================================================  altar, ward, gems

def altar_textures():
    T = "item/altar/"
    rng = np.random.default_rng(808)
    u, v = uv_grid(32, 32)
    pts = rng.uniform(0, 1, (7, 2))
    dd = np.stack([np.hypot(u - px, v - py) for px, py in pts])
    cell = np.argmin(dd, axis=0)
    srt = np.sort(dd, axis=0)
    edge = smooth(0.05, 0.0, srt[1] - srt[0])
    frames = []
    for f in range(12):
        ph = f / 12 * 2 * math.pi
        flum = 0.55 + 0.35 * ((cell * 0.41 + 0.15 * np.sin(ph + cell)) % 1)
        band_ = gauss(((v - f / 12) % 1) - 0.5, 0.12) * 0.25
        frames.append(gtex(0.62 + 0.3 * edge + band_, np.clip(flum + 0.45 * edge + band_, 0, 1)))
    save_texture(T + "crystal", frames, 2)
    cu, cv = uv_grid(16, 16)
    frames = [gtex(0.75 + 0.25 * math.sin(f / 12 * 2 * math.pi) + 0 * cu, 0.9 + 0.1 * np.sin(cv * 12 + f)) for f in range(12)]
    save_texture(T + "crystal_core", frames, 2)
    x, y, r, _ = polar(64, 64)
    frames = [gtex(gauss(np.hypot(x * 1.4, y), 0.55) * (0.35 + 0.15 * math.sin(f / 12 * 2 * math.pi)) * smooth(1.0, 0.85, r)) for f in range(12)]
    save_texture(T + "crystal_halo", frames, 2)
    save_texture(T + "rune_circle", rune_circle_frames(128, 32, 4242, 18, 6), 2)
    # obelisk stone: dark basalt with carved bevels
    stone = blank(32, 32)
    n = pnoise(32, 32, rng, 1.6)
    stone[..., :3] = mixc((24, 20, 30), (58, 52, 66), n[..., None])
    stone[..., 3] = 255
    for yy in (0, 31):
        stone[yy, :, :3] *= 0.6
    stone[:, 0, :3] *= 0.6
    stone[:, 31, :3] *= 0.6
    stone[1, 1:31, :3] = np.clip(stone[1, 1:31, :3] * 1.5, 0, 255)
    save_png(T + "obelisk_stone", stone)
    frames = []
    seeds = [int(s) for s in rng.integers(0, 1 << 30, 6)]
    for f in range(8):
        A = Art(16, 32, 4)
        for k, sd in enumerate(seeds):
            rune_glyph(A, 8, 3 + k * 5.2, 3.4, np.random.default_rng(sd), w=0.9)
        g = art_to_grey(A)
        pulse = 0.65 + 0.35 * math.sin(f / 8 * 2 * math.pi + 0)
        glow = Image.fromarray(np.clip(g[..., 3], 0, 255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(1.2))
        ga = np.asarray(glow, dtype=np.float64) / 255
        out = blank(32, 16)
        over(out, (255, 255, 255), ga * 0.6 * pulse)
        over_img(out, g * np.array([1, 1, 1, pulse]))
        frames.append(out)
    save_texture(T + "obelisk_runes", frames, 3)
    full = os.path.join(PACK, "assets", "chaoshearts", "textures", T + "obelisk_runes.png.mcmeta")
    with open(full, "w") as fh:
        json.dump({"animation": {"frametime": 3, "interpolate": True, "width": 16, "height": 32}}, fh, indent=2)
    # trial ward: a winged totem with a chaos heart gem
    A = Art(32, 32, 4)
    gold, goldl, goldd = (214, 170, 70), (255, 226, 130), (120, 84, 30)
    for sg in (-1, 1):
        A.poly([(16 + sg * 5, 10), (16 + sg * 14, 5), (16 + sg * 15, 11), (16 + sg * 12, 16), (16 + sg * 6, 17)], goldd)
        for k in range(3):
            A.line([(16 + sg * 6, 11 + k * 2), (16 + sg * (14 - k * 2), 6 + k * 3)], 1.0, goldl, 0.8)
    A.poly([(10, 6), (22, 6), (23, 27), (19, 31), (13, 31), (9, 27)], gold)
    A.rect(11, 7, 21, 9, goldl)
    A.rect(12, 11, 15, 13, (30, 16, 6)).rect(17, 11, 20, 13, (30, 16, 6))
    A.circle(13.5, 12, 0.9, (120, 255, 200)).circle(18.5, 12, 0.9, (120, 255, 200))
    A.poly(heart_pts(16, 21, 4.6), (150, 40, 220)).poly(heart_pts(15, 20, 1.8), (240, 180, 255), 0.8)
    A.line([(12, 27), (20, 27)], 1.0, goldd)
    save_png("item/trial_ward", outlined(A.img, (30, 18, 6)))


def altar_models():
    P = "chaoshearts:item/altar/"
    # crystal: centred, two blocks tall (-8..24), a 16-facet bipyramid with a glowing core
    tx = {"c": P + "crystal", "k": P + "crystal_core", "h": P + "crystal_halo", "particle": P + "crystal"}
    E = []
    layers = [(-8, -6, 0.5), (-6, -2, 1.4), (-2, 3, 2.4), (3, 13, 3.2), (13, 18, 2.4), (18, 22, 1.4), (22, 24, 0.5)]
    for y0, y1, w in layers:
        for rot in (0, 45, 22.5, -22.5):
            E.append(box((8 - w, y0, 8 - w), (8 + w, y1, 8 + w), "c", True, ("y", rot) if rot else None))
    E += [box((6.8, -2, 6.8), (9.2, 18, 9.2), "k", True), box((6.8, -2, 6.8), (9.2, 18, 9.2), "k", True, ("y", 45))]
    E += [plane_xy(-4, -8, 20, 24, 8, "h", True), plane_zy(-4, -8, 20, 24, 8, "h", True)]
    model("altar_crystal", tx, E, display=eye_display(0.4))
    item_def("altar_crystal", 0xB070FF)
    # rune circle: three blocks across, flat on the ground
    tx = {"r": P + "rune_circle", "g": "chaoshearts:item/fx/rune_glow", "particle": P + "rune_circle"}
    E = [plane_xz(-16, -16, 32, 32, 8.02, "r", True), plane_xz(-12, -12, 28, 28, 8.06, "g", True)]
    model("altar_rune", tx, E, display=eye_display(0.3))
    item_def("altar_rune", 0xB070FF)
    # obelisk: stands on the origin, 1.5 blocks tall, with glowing rune inlays on all four sides
    tx = {"s": P + "obelisk_stone", "r": P + "obelisk_runes", "particle": P + "obelisk_stone"}
    E = [box((1, 8, 1), (15, 10, 15), "s", False, proj=True, emit=0), box((2.5, 10, 2.5), (13.5, 12.5, 13.5), "s", False, proj=True, emit=0),
         box((4, 12.5, 4), (12, 28, 12), "s", False, emit=0), box((5, 28, 5), (11, 30, 11), "s", False, emit=0),
         box((6.5, 30, 6.5), (9.5, 31.4, 9.5), "s", False, emit=0), box((7.4, 31.4, 7.4), (8.6, 32, 8.6), "s", False, emit=0)]
    E += [plane_xy(5, 13.5, 11, 27, 12.05, "r", True, both=False, front="south"),
          plane_xy(5, 13.5, 11, 27, 3.95, "r", True, both=False, front="north"),
          plane_zy(5, 13.5, 11, 27, 12.05, "r", True, both=False, front="east"),
          plane_zy(5, 13.5, 11, 27, 3.95, "r", True, both=False, front="west")]
    for x0, z0, x1, z1 in ((7, 2.45, 9, 2.45), (7, 13.55, 9, 13.55)):
        E.append(plane_xy(x0, 10.4, x1, 12.1, z0, "r", True, both=True))
    model("altar_obelisk", tx, E, display=eye_display(0.4))
    item_def("altar_obelisk", 0xB070FF)
    write_json("assets/chaoshearts/models/item/trial_ward.json", {"parent": "minecraft:item/generated",
                                                                  "textures": {"layer0": "chaoshearts:item/trial_ward"}})
    item_def("trial_ward")


def heart_gems():
    for kind, main, sec in HEARTS:
        rng = np.random.default_rng(sum(map(ord, kind)))
        frames = []
        for i in range(8):
            beat = [1.0, 1.07, 1.0, 1.035, 1.0, 1.0, 1.0, 1.0][i]
            img, inside, hx, hy = shade_heart(main, sec, 0.9 * beat, np.random.default_rng(i), glow=0.15 * (beat - 1) * 10)
            motif(img, inside, kind, main, sec, rng, phase=i / 8)
            # a moving glint across the gem
            band_ = np.exp(-((hx + hy * 0.6 - (i / 8 * 3.4 - 1.7)) ** 2) * 14) * inside
            img[..., :3] = np.clip(img[..., :3] + band_[..., None] * 70, 0, 255)
            # soft halo outside the outline
            halo = np.zeros(inside.shape)
            m = inside | outline(inside)
            g2 = m.copy()
            for _ in range(2):
                g2 = g2 | outline(g2)
            halo[g2 & ~m] = 1
            lite = np.clip(rgb(main) * 0.6 + 100, 0, 255)
            sel = halo > 0
            img[sel, :3] = lite
            img[sel, 3] = 70 + 40 * math.sin(i / 8 * 2 * math.pi)
            frames.append(img)
        save_texture(f"item/heart_{kind}", frames, 2)
        write_json(f"assets/chaoshearts/models/item/heart_{kind}.json", {
            "parent": "minecraft:item/generated", "textures": {"layer0": f"chaoshearts:item/heart_{kind}"}})
        item_def(f"heart_{kind}")

def pack_icon():
    img, inside, _, _ = shade_heart(0x8A3CFF, 0x14002B, 0.8, np.random.default_rng(2), glow=0.3)
    # the heart split into the ten colours like a stained glass window
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


def rec_fx(name, rng):
    if name == "hit_marker":
        d = 0.07
        n = int(d * SR)
        click = osc(3200, d) * env(n, 0.0005, 0.018) * 0.7 + osc(5300, d) * env(n, 0.0003, 0.008) * 0.4
        return click + fft_filter(noise(d, rng), 2500, 11000) * env(n, 0.0003, 0.006) * 0.6
    if name == "heart_shuffle":
        return reverb(mix(heartbeat(rng) * 0.9, at(whoosh(rng, 0.45, 300, 6000) * 0.7, 0.06), at(bell(880, 0.5, rng) * 0.22, 0.28)), rng, 1.0, 0.3)
    if name == "altar_hum":
        return altar_hum_loop(rng)
    if name == "altar_activate":
        swell = reverse(reverb(chord([note(0, 110), note(7, 110), note(12, 110)], 1.2, "saw", rng, 0.01, 0.8), rng, 1.2, 0.7))[:int(1.5 * SR)]
        bells = mix(*[at(bell(note(s, 440), 1.6, rng) * 0.35, i * 0.08) for i, s in enumerate((0, 7, 12, 19))])
        return reverb(mix(fft_filter(swell, 40, 3000), at(boom(rng, 1.6, 80, 24, 3) * 0.9, 1.45), at(bells, 1.5),
                          at(crackle(rng, 1.0, 80) * 0.4, 1.45)), rng, 2.2, 0.35)
    if name == "impact_heavy":
        snap = fft_filter(noise(0.08, rng), 1000, 8000) * env(int(0.08 * SR), 0.0005, 0.02) * 0.8
        return reverb(mix(boom(rng, 1.1, 95, 26, 3.5), crackle(rng, 0.5, 120, 5000) * 0.7, snap), rng, 1.0, 0.22)
    if name == "impact_light":
        snap = fft_filter(noise(0.05, rng), 1500, 9000) * env(int(0.05 * SR), 0.0005, 0.012)
        return mix(boom(rng, 0.25, 160, 70, 2) * 0.7, snap)
    if name == "whoosh":
        return whoosh(rng, 0.5, 300, 4500)
    if name == "charge_up":
        d = 1.3
        n = int(d * SR)
        ramp = np.linspace(0, 1, n) ** 1.4
        trem = 0.65 + 0.35 * osc(sweep(6, 30, d), d)
        tone = fft_filter(osc(sweep(110, 880, d, 1.6), d, "saw") + osc(sweep(165, 1320, d, 1.6), d, "saw") * 0.5, 60, 5000) * 0.5
        hiss = lowpass_sweep(noise(d, rng), 300, 9000) * 0.6
        return (tone * trem + hiss) * ramp
    if name == "rumble":
        d = 2.2
        return lowpass_sweep(noise(d, rng), 220, 70) * adsr(int(d * SR), 0.4, 0.2, 0.8, 0.8) * 3 + drone(36, d, rng, 0.4) * 0.4
    if name == "ui_click":
        d = 0.04
        n = int(d * SR)
        return osc(1800, d, "tri") * env(n, 0.0003, 0.01) + fft_filter(noise(d, rng), 3000, 12000) * env(n, 0.0002, 0.003) * 0.5
    if name == "ui_open":
        return reverb(mix(bell(note(0, 880), 0.5, rng) * 0.4, at(bell(note(7, 880), 0.6, rng) * 0.4, 0.07), whoosh(rng, 0.25, 1500, 7000) * 0.25), rng, 0.9, 0.3)
    if name == "glass_shatter":
        return reverb(mix(glass(rng, 1.1, 2200) * 1.2, crackle(rng, 0.4, 400, 14000) * 0.8, boom(rng, 0.3, 200, 90) * 0.3), rng, 1.0, 0.3)
    if name == "heart_beat":
        return reverb(heartbeat(rng), rng, 0.6, 0.15)


def altar_hum_loop(rng):
    """Exactly 4 s; every partial and the LFO complete whole cycles and the noise is filtered
    circularly, so the sound loops without a seam."""
    N = 4 * SR
    t = np.arange(N) / SR
    s = np.zeros(N)
    for f, a in ((55.0, 1.0), (55.25, 0.8), (82.5, 0.45), (110.0, 0.35), (165.0, 0.18), (220.5, 0.08), (330.0, 0.05)):
        s += a * np.sin(2 * np.pi * f * t)
    lfo = 0.78 + 0.22 * np.sin(2 * np.pi * 0.5 * t)
    air = fft_filter(rng.normal(0, 1, N), 60, 400) * 0.6 + fft_filter(rng.normal(0, 1, N), 2000, 5000) * 0.05 * (0.5 + 0.5 * np.sin(2 * np.pi * 0.25 * t))
    return dist(s * lfo * 0.3, 1.4) + air * 0.4


LOOPS = {"altar_hum"}


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
    ("fx", rec_fx, ["hit_marker", "heart_shuffle", "altar_hum", "altar_activate", "impact_heavy", "impact_light", "whoosh",
                    "charge_up", "rumble", "ui_click", "ui_open", "glass_shatter", "heart_beat"]),
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
    "hit_marker": "Hit", "heart_shuffle": "Heart shuffled", "altar_hum": "Altar hums", "altar_activate": "Altar awakens",
    "impact_heavy": "Heavy impact", "impact_light": "Impact", "whoosh": "Whoosh", "charge_up": "Power gathers",
    "rumble": "Ground rumbles", "ui_click": "Click", "ui_open": "Menu opens", "glass_shatter": "Glass shatters",
    "heart_beat": "Heartbeat",
}

LANG_EXTRA = {
    "death.attack.ch_ability": "%1$s was torn apart by Chaos",
    "death.attack.ch_ability.player": "%1$s was torn apart by %2$s's Chaos Heart",
    "death.attack.ch_bleed": "%1$s bled out",
    "death.attack.ch_bleed.player": "%1$s bled out fighting %2$s",
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


def sound_defs():
    """sounds.json and the language file (needs no synthesis)."""
    defs = {}
    lang = {}
    for name in SOUNDS:
        far = name.startswith(("boss", "eye", "trial", "heart_awaken", "altar"))
        d = {"sounds": [{"name": f"chaoshearts:sfx/{name}", "attenuation_distance": 32 if far else 20}]}
        sub = SUBTITLES.get(name) or name.split("_", 1)[0].capitalize() + " heart: " + name.split("_", 1)[1].replace("_", " ")
        d["subtitle"] = f"subtitles.chaoshearts.{name}"
        lang[f"subtitles.chaoshearts.{name}"] = sub
        defs[name] = d
    for kind in THEMES:
        defs[f"trial_music_{kind}"] = {"sounds": [{"name": f"chaoshearts:music/trial_music_{kind}", "stream": True, "volume": 0.8}]}
    lang.update(LANG_EXTRA)
    write_json("assets/chaoshearts/sounds.json", defs)
    write_json("assets/chaoshearts/lang/en_us.json", lang)


def audio():
    folder = os.path.join(PACK, "assets", "chaoshearts", "sounds")
    for name, fn in SOUNDS.items():
        rng = np.random.default_rng(sum(map(ord, name)) * 7919)
        x = fn(name, rng)
        if x is None:
            raise SystemExit(f"no recipe produced audio for {name}")
        if name in LOOPS:
            x = normalize(x, 0.85)
        else:
            x = fade(normalize(x, 0.92))
            # trim trailing silence left by reverb tails
            thr = np.nonzero(np.abs(x) > 0.004)[0]
            if len(thr):
                x = fade(x[:thr[-1] + int(0.05 * SR)])
        write_ogg(name, x, os.path.join(folder, "sfx"))
        print("sfx", name, f"{len(x) / SR:.2f}s")
    for kind in THEMES:
        rng = np.random.default_rng(sum(map(ord, kind)) * 104729)
        x = music(kind, rng)
        write_ogg(f"trial_music_{kind}", x, os.path.join(folder, "music"), 3)
        print("music", kind, f"{len(x) / SR:.2f}s")

def main():
    with_audio = "--no-audio" not in sys.argv
    if with_audio and not shutil.which("ffmpeg"):
        sys.exit("ffmpeg is needed to encode the sounds")
    sounds_dir = os.path.join(PACK, "assets", "chaoshearts", "sounds")
    kept = None
    if not with_audio and os.path.isdir(sounds_dir):
        kept = tempfile.mkdtemp()
        shutil.move(sounds_dir, os.path.join(kept, "sounds"))
    if os.path.isdir(PACK):
        shutil.rmtree(PACK)
    os.makedirs(PACK)
    if kept:
        os.makedirs(os.path.dirname(sounds_dir), exist_ok=True)
        shutil.move(os.path.join(kept, "sounds"), sounds_dir)
        shutil.rmtree(kept)
    write_json("pack.mcmeta", {"pack": {
        "description": [{"text": "Chaos Hearts", "color": "#c04cff", "bold": True}, {"text": "\nHearts, trials, effects and sounds", "color": "gray"}],
        "min_format": 75, "max_format": 75}})
    hud()
    fx_textures()
    fx_models()
    eye_textures()
    eye_models()
    altar_textures()
    altar_models()
    heart_gems()
    write_item_defs()
    pack_icon()
    sound_defs()
    if with_audio:
        audio()
    print("resource pack written to", PACK)


if __name__ == "__main__":
    main()
