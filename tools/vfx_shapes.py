"""
Particle geometry for the Chaos Hearts VFX library, generated into datapack/data/ch/function/gen/vfx/.

Every shape is a macro function taking the particle as $(p) (a full particle spec such as
"minecraft:dust{color:[1.0,0.2,0.2],scale:1.2}"). Shapes in local coordinates (^) follow the execution rotation, so a
caller spins or aims them with `rotated`; flat shapes lie in the plane of the rotation (use `rotated <yaw> 0` for the
ground). Shapes marked "world" use ~ coordinates and ignore rotation. Shapes with a velocity also take $(v) (speed).

Called from tools/build_datapack.py; see DESIGN.md "VFX library" for the list.
"""
import math
import os
import random

SHAPES = {}


def f2(x):
    s = f"{x:.2f}".rstrip("0").rstrip(".")
    return "0" if s in ("-0", "") else s


def loc(pts):
    return [f"$particle $(p) ^{f2(x)} ^{f2(y)} ^{f2(z)} 0 0 0 0 1" for x, y, z in pts]


def world(pts):
    return [f"$particle $(p) ~{f2(x)} ~{f2(y)} ~{f2(z)} 0 0 0 0 1" for x, y, z in pts]


def vel(pts, dirs):
    out = []
    for (x, y, z), (dx, dy, dz) in zip(pts, dirs):
        out.append(f"$particle $(p) ~{f2(x)} ~{f2(y)} ~{f2(z)} {f2(dx)} {f2(dy)} {f2(dz)} $(v) 0")
    return out


def add(name, doc, lines):
    SHAPES[name] = [f"# {doc}"] + lines


# ---- geometry helpers (x right, y up, z forward)

def circle(r, n, y=0.0, a0=0.0):
    return [(r * math.sin(a0 + 2 * math.pi * i / n), y, r * math.cos(a0 + 2 * math.pi * i / n)) for i in range(n)]


def seg(p, q, step):
    d = math.dist(p, q)
    k = max(1, round(d / step))
    return [tuple(p[j] + (q[j] - p[j]) * i / k for j in range(3)) for i in range(k + 1)]


def poly(pts, step, closed=True):
    out = []
    m = len(pts) if closed else len(pts) - 1
    for i in range(m):
        s = seg(pts[i], pts[(i + 1) % len(pts)], step)
        out += s[:-1]
    if not closed:
        out.append(pts[-1])
    return out


def ncirc(r, density=2.4, lo=10):
    return max(lo, round(2 * math.pi * r * density))


def fib_sphere(r, n):
    pts = []
    g = math.pi * (3 - math.sqrt(5))
    for i in range(n):
        y = 1 - 2 * (i + 0.5) / n
        rr = math.sqrt(1 - y * y)
        pts.append((r * rr * math.cos(g * i), r * y, r * rr * math.sin(g * i)))
    return pts


def dedupe(pts, eps=0.12):
    out = []
    for p in pts:
        if all(math.dist(p, q) > eps for q in out[-40:]):
            out.append(p)
    return out


def jag_line(p, q, n, amp, rng):
    pts = [p]
    for i in range(1, n):
        t = i / n
        pts.append(tuple(p[j] + (q[j] - p[j]) * t + (rng.uniform(-amp, amp) if j != 1 or q[1] == p[1] else rng.uniform(-amp, amp) * 0.4) for j in range(3)))
    pts.append(q)
    return pts


def gen_shapes():
    SHAPES.clear()
    rng = random.Random(1729)

    # rings
    for r in (0.5, 1, 1.5, 2, 3, 4, 5, 6, 7, 8, 10, 12):
        add(f"ring{str(r).replace('.', '_')}", f"Flat ring of radius {r} (local).", loc(circle(r, ncirc(r))))
    # dynamic-radius rings: $(r) is the radius
    for n in (16, 32, 48):
        add(f"mring{n}", f"Flat ring of {n} points with radius $(r) (local).",
            [f"$execute rotated ~{f2(360 * i / n)} ~ run particle $(p) ^ ^ ^$(r) 0 0 0 0 1" for i in range(n)])
    # spokes with velocity (ground streaks), and a vertical fountain
    for n in (8, 16, 24):
        lines = []
        for i in range(n):
            a = 2 * math.pi * i / n
            lines.append(f"$particle $(p) ~ ~0.15 ~ {f2(math.sin(a))} 0.04 {f2(math.cos(a))} $(v) 0")
        add(f"streak{n}", f"{n} particles shot outward along the ground at speed $(v) (world).", lines)
    # spheres and bursts
    for r, n in ((0.5, 14), (1, 26), (1.5, 44), (2, 64), (3, 100), (4, 140), (6, 200)):
        k = str(r).replace('.', '_')
        add(f"sphere{k}", f"Fibonacci sphere shell of radius {r} (world).", world(fib_sphere(r, n)))
    for n in (16, 32, 64):
        pts = fib_sphere(1, n)
        add(f"burst{n}", f"{n} particles exploding outward in every direction at speed $(v) (world).",
            vel([(x * 0.25, y * 0.25, z * 0.25) for x, y, z in pts], pts))
        add(f"fount{n}", f"{n} particles thrown up and out like a fountain at speed $(v) (world).",
            vel([(0, 0.1, 0)] * n, [(x * 0.5, abs(y) + 0.6, z * 0.5) for x, y, z in pts]))
    for r, n in ((2, 24), (3, 36), (4, 48), (6, 64), (8, 80)):
        pts = fib_sphere(r, n)
        add(f"implode{r}", f"{n} particles on a sphere of radius {r} rushing to the centre at speed $(v) (world).",
            vel(pts, [(-x / r, -y / r, -z / r) for x, y, z in pts]))
        ring = circle(r, n)
        add(f"inring{r}", f"{n} particles on a ground ring of radius {r} rushing inward at speed $(v) (world).",
            vel([(x, 0.15, z) for x, _, z in ring], [(-x / r, 0.02, -z / r) for x, _, z in ring]))
    # domes and columns
    for r in (2, 3, 5, 8):
        pts = []
        for k in range(1, 5):
            phi = k * math.pi / 10
            rr, y = r * math.cos(phi), r * math.sin(phi)
            pts += circle(rr, ncirc(rr, 1.6), y, k * 0.2)
        for i in range(8):
            a = 2 * math.pi * i / 8
            for k in range(1, 9):
                phi = k * math.pi / 18
                pts.append((r * math.cos(phi) * math.sin(a), r * math.sin(phi), r * math.cos(phi) * math.cos(a)))
        add(f"dome{r}", f"Hemisphere cage of radius {r}: latitude rings and 8 meridians (world).", world(dedupe(pts)))
    for r, h in ((1, 3), (1.5, 6), (2, 10), (3, 16), (4, 24)):
        pts = []
        for i in range(8):
            a = 2 * math.pi * i / 8
            pts += seg((r * math.sin(a), 0, r * math.cos(a)), (r * math.sin(a), h, r * math.cos(a)), max(0.5, h / 14))
        for y in (0, h / 2, h):
            pts += circle(r, ncirc(r, 2), y)
        add(f"cyl{str(r).replace('.', '_')}", f"Cylinder cage radius {r}, height {h} (local).", loc(dedupe(pts)))
    # helices (vertical, local)
    for h, r in ((3, 0.8), (6, 1.0), (10, 1.3), (16, 1.6)):
        pts = []
        n = int(h * 9)
        for strand in (0, math.pi):
            for i in range(n):
                y = h * i / n
                a = strand + y * 2.2
                pts.append((r * math.sin(a), y, r * math.cos(a)))
        add(f"helix{h}", f"Double helix {h} blocks tall, radius {r} (local).", loc(pts))
    # tornado funnel
    for h in (6, 10):
        pts = []
        n = h * 14
        for strand in range(3):
            for i in range(n):
                t = i / n
                y = h * t
                rr = 0.4 + 3.6 * t * t * (h / 10 + 0.4)
                a = strand * 2 * math.pi / 3 + t * 9
                pts.append((rr * math.sin(a), y, rr * math.cos(a)))
        add(f"vortex{h}", f"Three-armed tornado funnel {h} blocks tall (local).", loc(pts))
    # spirals (ground galaxies)
    for r in (3, 5, 8):
        pts = []
        for arm in range(3):
            n = r * 10
            for i in range(n):
                t = i / n
                rr = 0.3 + r * t
                a = arm * 2 * math.pi / 3 + t * 5.5
                pts.append((rr * math.sin(a), 0, rr * math.cos(a)))
        add(f"spiral{r}", f"Three-armed ground spiral of radius {r} (local).", loc(pts))
    # stars, polygons
    for r in (2, 3, 5, 7):
        for k in (5, 6, 8):
            outer = [(r * math.sin(2 * math.pi * i / k), 0, r * math.cos(2 * math.pi * i / k)) for i in range(k)]
            if k == 5:
                path = [outer[(i * 2) % 5] for i in range(5)]
                pts = poly(path, 0.32)
            elif k == 6:
                pts = poly(outer[0::2], 0.32) + poly(outer[1::2], 0.32)
            else:
                pts = poly([outer[(i * 3) % 8] for i in range(8)], 0.36)
            add(f"star{k}_{r}", f"{k}-pointed star polygon of radius {r} (local).", loc(dedupe(pts, 0.1)))
        add(f"hex{r}", f"Hexagon of radius {r} (local).", loc(poly(circle(r, 6), 0.3)))
    # rune circles: two rings, a hexagram, tick marks, an inner ring and six vertex rings
    for r in (2, 3, 5, 7):
        den = 2.6 if r < 5 else 1.9
        pts = circle(r, ncirc(r, den)) + circle(r * 0.86, ncirc(r * 0.86, den - 0.4))
        hexa = circle(r * 0.86, 6)
        pts += poly(hexa[0::2], 0.3 + r * 0.02) + poly(hexa[1::2], 0.3 + r * 0.02)
        pts += circle(r * 0.38, ncirc(r * 0.38, 3))
        for i in range(24):
            a = 2 * math.pi * (i + 0.5) / 24
            pts += seg((r * 0.88 * math.sin(a), 0, r * 0.88 * math.cos(a)), (r * 0.98 * math.sin(a), 0, r * 0.98 * math.cos(a)), 0.2)
        for x, _, z in hexa:
            pts += [(x + px, 0, z + pz) for px, _, pz in circle(r * 0.09 + 0.15, 8)]
        add(f"rune{r}", f"Rune circle of radius {r}: double ring, hexagram, ticks, inner ring, vertex seals (local).",
            loc(dedupe(pts, 0.1)))
    # snowflake
    for r in (2, 4, 6):
        pts = []
        for i in range(6):
            a = 2 * math.pi * i / 6
            ux, uz = math.sin(a), math.cos(a)
            pts += seg((0, 0, 0), (r * ux, 0, r * uz), 0.25)
            for t in (0.4, 0.7):
                bx, bz = r * t * ux, r * t * uz
                for s in (-1, 1):
                    b = a + s * math.pi / 3.2
                    L = r * (0.38 if t == 0.4 else 0.24)
                    pts += seg((bx, 0, bz), (bx + L * math.sin(b), 0, bz + L * math.cos(b)), 0.25)
        pts += poly(circle(r * 0.22, 6), 0.2)
        add(f"flake{r}", f"Six-armed snowflake of radius {r} (local).", loc(dedupe(pts, 0.1)))
    # clock face and a clock hand
    for r in (3, 5, 8):
        pts = circle(r, ncirc(r, 2.4)) + circle(r * 0.92, ncirc(r * 0.92, 1.4))
        for i in range(12):
            a = 2 * math.pi * i / 12
            L = 0.22 if i % 3 else 0.36
            pts += seg((r * (0.9 - L) * math.sin(a), 0, r * (0.9 - L) * math.cos(a)), (r * 0.9 * math.sin(a), 0, r * 0.9 * math.cos(a)), 0.15)
        add(f"clock{r}", f"Clock face of radius {r} with 12 hour marks (local).", loc(dedupe(pts, 0.08)))
        add(f"hand{r}", f"Clock hand of length {r} pointing forward (local).", loc(seg((0, 0, 0), (0, 0, r * 0.8), 0.2)))
    # lines and braids along the look (+z)
    for L in (4, 8, 12, 16, 24, 32):
        add(f"line{L}", f"Straight line {L} blocks forward (local).", loc(seg((0, 0, 0.5), (0, 0, L), 0.3)))
        pts = []
        n = int(L * 6)
        for strand in (0, math.pi):
            for i in range(n):
                z = 0.5 + (L - 0.5) * i / n
                a = strand + z * 2.6
                pts.append((0.38 * math.sin(a), 0.38 * math.cos(a), z))
        add(f"braid{L}", f"Two strands twisting around a line {L} blocks forward (local).", loc(pts))
        rings = []
        for k in range(1, int(L / 2) + 1):
            rings += [(x, y, k * 2.0) for x, _, y in circle(0.55, 10)]
        add(f"tube{L}", f"Rings every 2 blocks along a line {L} blocks forward, facing it (local).", loc(rings))
    # cones forward
    for L in (4, 6, 10):
        R = L * 0.45
        pts = []
        for i in range(10):
            a = 2 * math.pi * i / 10
            pts += seg((0, 0, 0.4), (R * math.sin(a), R * math.cos(a), L), 0.4)
        for t in (0.5, 1.0):
            pts += [(x, z, L * t) for x, _, z in circle(R * t, ncirc(R * t, 2))]
        add(f"cone{L}", f"Cone opening {L} blocks forward (local).", loc(dedupe(pts)))
        # velocity spray forward: dirs in local space cannot be used with world deltas, so the spray uses ^ positions
        sp = []
        for i in range(30):
            a = rng.uniform(0, 2 * math.pi)
            rr = rng.uniform(0, R) * math.sqrt(rng.random())
            z = rng.uniform(0.6, L)
            sp.append((rr * math.sin(a) * z / L, rr * math.cos(a) * z / L, z))
        add(f"conefill{L}", f"Cone of {L} blocks filled with 30 scattered points (local).", loc(sp))
    # arcs (slashes) in the local XZ plane opening forward
    for r in (2, 3, 4, 6):
        pts = []
        for k, rr in enumerate((r, r * 0.9, r * 0.8)):
            n = ncirc(rr, 1.0 + 0.4 * (2 - k))
            for i in range(n + 1):
                a = math.radians(-75 + 150 * i / n)
                pts.append((rr * math.sin(a), 0, rr * math.cos(a)))
        add(f"arc{r}", f"150 degree crescent of radius {r} opening forward (local).", loc(pts))
    # cracks on the ground (three variants)
    for r in (3, 5, 8):
        for v in range(3):
            pts = []
            for i in range(7):
                a = 2 * math.pi * (i + rng.uniform(-0.3, 0.3)) / 7
                end = (r * rng.uniform(0.7, 1.0) * math.sin(a), 0, r * rng.uniform(0.7, 1.0) * math.cos(a))
                path = jag_line((0, 0, 0), end, 6, r * 0.08, rng)
                pts += poly(path, 0.28, closed=False)
                if rng.random() < 0.7:
                    mid = path[3]
                    b = a + rng.choice((-1, 1)) * 0.7
                    pts += poly(jag_line(mid, (mid[0] + r * 0.35 * math.sin(b), 0, mid[2] + r * 0.35 * math.cos(b)), 3, r * 0.05, rng), 0.28, closed=False)
            add(f"crack{r}_{v}", f"Jagged ground cracks radiating {r} blocks, variant {v} (local).", loc(dedupe([(x, 0, z) for x, _, z in pts], 0.1)))
    # lightning bolts from the sky (world) and forward (local)
    for v in range(4):
        pts = []
        main = jag_line((0, 16, 0), (0, 0, 0), 14, 1.1, rng)
        pts += poly(main, 0.3, closed=False)
        for _ in range(3):
            k = rng.randint(2, 9)
            p = main[k]
            q = (p[0] + rng.uniform(-3, 3), p[1] - rng.uniform(2, 5), p[2] + rng.uniform(-3, 3))
            pts += poly(jag_line(p, q, 4, 0.6, rng), 0.3, closed=False)
        add(f"bolt{v}", f"Forked lightning bolt 16 blocks down to here, variant {v} (world).", world(pts))
    for L in (8, 16):
        for v in range(3):
            main = jag_line((0, 0, 0.5), (0, 0, L), int(L * 1.2), 0.45, rng)
            pts = poly(main, 0.25, closed=False)
            for _ in range(2):
                k = rng.randint(2, len(main) - 3)
                p = main[k]
                q = (p[0] + rng.uniform(-1.6, 1.6), p[1] + rng.uniform(-1.2, 1.2), p[2] + rng.uniform(1, 3))
                pts += poly(jag_line(p, q, 4, 0.3, rng), 0.25, closed=False)
            add(f"zap{L}_{v}", f"Jagged lightning {L} blocks forward, variant {v} (local).", loc(pts))
    # crown of spikes
    for r in (1, 3, 5):
        pts = []
        for i in range(10):
            a = 2 * math.pi * i / 10
            h = r * (0.9 if i % 2 else 1.6)
            base = (r * math.sin(a), 0, r * math.cos(a))
            l = (r * math.sin(a - 0.18), 0, r * math.cos(a - 0.18))
            rr_ = (r * math.sin(a + 0.18), 0, r * math.cos(a + 0.18))
            tip = (r * 0.9 * math.sin(a), h, r * 0.9 * math.cos(a))
            st = 0.22 + r * 0.06
            pts += seg(l, tip, st) + seg(rr_, tip, st)
        add(f"crown{r}", f"Ring of 10 jagged spikes, radius {r} (local).", loc(dedupe(pts, 0.08)))
    # vertical silhouettes facing the viewer (local XY plane, centred at y=0)
    for s in (1, 2, 4):
        pts = []
        n = 60
        for i in range(n):
            t = 2 * math.pi * i / n
            x = 16 * math.sin(t) ** 3
            y = 13 * math.cos(t) - 5 * math.cos(2 * t) - 2 * math.cos(3 * t) - math.cos(4 * t)
            pts.append((x / 16 * s, y / 16 * s, 0))
        add(f"heart{s}", f"Heart outline {s * 2} blocks wide, upright, facing forward (local).", loc(pts))
        eye = []
        for i in range(40):
            t = math.pi * i / 39
            eye.append((s * math.cos(t), s * 0.45 * math.sin(t), 0))
            eye.append((s * math.cos(t), -s * 0.45 * math.sin(t), 0))
        eye += [(x * s * 0.32, z * s * 0.32, 0) for x, _, z in circle(1, 18)]
        eye += [(x * s * 0.12, z * s * 0.12, 0) for x, _, z in circle(1, 8)]
        add(f"eye{s}", f"Staring eye {s * 2} blocks wide, upright, facing forward (local).", loc(eye))
        sk = []
        sk += [(x * s * 0.8, z * s * 0.85 + s * 0.15, 0) for x, _, z in circle(1, 30)]
        for cx in (-0.33, 0.33):
            sk += [(cx * s + x * s * 0.2, s * 0.1 + z * s * 0.22, 0) for x, _, z in circle(1, 12)]
        sk += seg((-s * 0.1, -s * 0.2, 0), (0, -s * 0.05, 0), 0.12) + seg((s * 0.1, -s * 0.2, 0), (0, -s * 0.05, 0), 0.12)
        sk += seg((-s * 0.45, -s * 0.55, 0), (s * 0.45, -s * 0.55, 0), 0.18)
        for k in range(-3, 4):
            sk += seg((k * s * 0.13, -s * 0.45, 0), (k * s * 0.13, -s * 0.7, 0), 0.12)
        add(f"skull{s}", f"Skull silhouette {s * 2} blocks wide, upright, facing forward (local).", loc(dedupe(sk, 0.06)))
    # wings behind the caster (local: x sideways, y up, z back is negative)
    for s in (1, 2):
        pts = []
        for side in (-1, 1):
            for f in range(7):
                ang = math.radians(15 + f * 14)
                L = s * (1.4 + 1.2 * math.sin(math.pi * (f + 1) / 8))
                root = (side * 0.25, 1.4, -0.35)
                tip = (side * (0.25 + L * math.cos(ang)), 1.4 + L * math.sin(ang) - f * 0.12 * s, -0.35 - 0.15 * f)
                pts += seg(root, tip, 0.16)
        add(f"wings{s}", f"Pair of feathered wings behind the caster, span {s * 6} (local, at the feet).", loc(pts))
    # titan spikes: eight rock fangs in a ring
    for r in (2, 4, 6):
        pts = []
        for i in range(8):
            a = 2 * math.pi * i / 8 + 0.2
            c = (r * math.sin(a), 0, r * math.cos(a))
            h = r * rng.uniform(0.5, 0.8) + 1
            w = 0.35 + r * 0.06
            tip = (c[0] * 1.05, h, c[2] * 1.05)
            for dx, dz in ((w, 0), (-w, 0), (0, w), (0, -w)):
                pts += seg((c[0] + dx, 0, c[2] + dz), tip, 0.3 + r * 0.04)
        add(f"fangs{r}", f"Eight rock fangs in a ring of radius {r} (local).", loc(dedupe(pts, 0.08)))
    # galaxy disc: dense two-arm spiral with a bright core
    for r in (3, 6):
        pts = []
        for arm in range(2):
            n = r * 22
            for i in range(n):
                t = i / n
                rr = r * t
                a = arm * math.pi + t * 7
                sp = 0.25 + t * 0.6
                pts.append((rr * math.sin(a) + rng.uniform(-sp, sp) * 0.4, rng.uniform(-0.08, 0.08), rr * math.cos(a) + rng.uniform(-sp, sp) * 0.4))
        pts += fib_sphere(0.45, 20)
        add(f"galaxy{r}", f"Two-armed galaxy disc of radius {r} with a bright core (local).", loc(pts))
    return SHAPES


def write_shapes(fn_dir):
    out = os.path.join(fn_dir, "gen", "vfx")
    os.makedirs(out, exist_ok=True)
    total = 0
    for name, lines in gen_shapes().items():
        with open(os.path.join(out, name + ".mcfunction"), "w", encoding="utf-8", newline="\n") as f:
            f.write("\n".join(lines) + "\n")
        total += len(lines) - 1
    return len(SHAPES), total


# Theme particles per heart: a = a particle that flies well with velocity, b = a sparkle, c = a heavy/ambient one.
THEMES = {
    "rage": ("minecraft:flame", "minecraft:crimson_spore", 'minecraft:block{block_state:"minecraft:redstone_block"}'),
    "speed": ("minecraft:electric_spark", "minecraft:end_rod", "minecraft:firework"),
    "infernal": ("minecraft:flame", "minecraft:lava", "minecraft:large_smoke"),
    "void": ("minecraft:reverse_portal", "minecraft:portal", "minecraft:squid_ink"),
    "frozen": ("minecraft:snowflake", "minecraft:end_rod", "minecraft:item_snowball"),
    "storm": ("minecraft:electric_spark", "minecraft:end_rod", "minecraft:cloud"),
    "blood": ('minecraft:block{block_state:"minecraft:redstone_block"}', "minecraft:crimson_spore",
              'minecraft:falling_dust{block_state:"minecraft:redstone_block"}'),
    "titan": ('minecraft:block{block_state:"minecraft:cobblestone"}', 'minecraft:block{block_state:"minecraft:gold_block"}', "minecraft:cloud"),
    "celestial": ("minecraft:end_rod", "minecraft:firework", "minecraft:white_ash"),
    "corruption": ("minecraft:sneeze", "minecraft:sculk_soul", "minecraft:squid_ink"),
}


def theme_table(fn_dir, types, extra=None):
    """Maps every colour used in a heart's kit and trial to that heart's theme, so the shared FX calls can
    pick themed particles from nothing but the colour they were given."""
    import re
    votes = {}
    for _, h, *_ in types:
        for sub in ("kit", "trials", "vfx"):
            d = os.path.join(fn_dir, sub, h)
            for root, _, names in os.walk(d):
                for n in names:
                    if n.endswith(".mcfunction"):
                        for c in re.findall(r"color:(\d{3,8})\b", open(os.path.join(root, n), encoding="utf-8").read()):
                            votes.setdefault(c, {}).setdefault(h, 0)
                            votes[c][h] += 1
    for _, h, _, col, *_ in types:
        c = str(int(col[1:], 16))
        votes.setdefault(c, {}).setdefault(h, 0)
        votes[c][h] += 1000
    for c, h in (extra or {}).items():
        votes.setdefault(str(c), {}).setdefault(h, 0)
        votes[str(c)][h] += 500
    table = {}
    for c, v in votes.items():
        h = max(v, key=v.get)
        a, b, cc = THEMES[h]
        table["c" + c] = {"a": a, "b": b, "c": cc}
    return table
