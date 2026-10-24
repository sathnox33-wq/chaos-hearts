"""
Signature VFX for every ability: layered particle choreography played on top of the kit's own effects the moment a
cast succeeds. Generated into datapack/data/ch/function/gen/sig/ by tools/build_datapack.py.

core/cast saves the slot, variant and movement in #sig_s, #sig_v and #sig_m (ch.tmp) and calls gen/vfx_sig, which runs
gen/sig/<heart>_a<slot>. Each entry below lists the commands for one variant (0 level, 1 up, 2 down; "all" runs for
every variant first). Shapes are in gen/vfx (tools/vfx_shapes.py), timelines in vfx/tl.

Helpers (they return command strings):
  col(c)                switch palette to colour c (decimal RGB): sets d/e/t/k dusts and the heart's a/b/c particles
  sh(shape, k, v, at)   draw a shape with palette particle k (d e t k a b c) at speed v
  raw(shape, p, v, at)  draw a shape with an explicit particle
  go/gof/gor(f, n, ...) start timeline vfx/tl/<f>: here / riding on the caster / riding and facing like the caster
"""
EYE = "anchored eyes positioned ^ ^ ^"
FWD = lambda d: f"anchored eyes positioned ^ ^ ^{d}"
FEET_FWD = lambda d: f"positioned ^ ^0.1 ^{d} rotated ~ 0"


def _at(at):
    return f"execute {at} run " if at else ""


def col(c):
    return f"function ch:vfx/col {{color:{c}}}"


def sh(s, k, v=0, at=""):
    return f"{_at(at)}function ch:vfx/sh {{s:\"{s}\",k:\"{k}\",v:{v}}}"


def raw(s, p, v=0, at=""):
    return f"{_at(at)}function ch:gen/vfx/{s} {{p:'{p}',v:{v}}}"


def go(f, n, spin=0, dy=0, fw=0, at=""):
    return f"{_at(at)}function ch:vfx/go {{f:\"ch:vfx/tl/{f}\",n:{n},spin:{spin},dy:{dy},fw:{fw}}}"


def gof(f, n, spin=0, at=""):
    return f"{_at(at)}function ch:vfx/gof {{f:\"ch:vfx/tl/{f}\",n:{n},spin:{spin}}}"


def gor(f, n, at=""):
    return f"{_at(at)}function ch:vfx/gor {{f:\"ch:vfx/tl/{f}\",n:{n}}}"


def cmd(c):
    return c


GROUND = "rotated ~ 0"
LEVEL = "rotated 0 0"

# heart colours and a second colour for contrast layers
C = {
    "rage": (14689835, 3801088), "speed": (16114754, 2741234), "infernal": (16742938, 9182208),
    "void": (9059583, 1310763), "frozen": (10217471, 3108776), "storm": (5220607, 15267583),
    "blood": (10357535, 2818054), "titan": (13215836, 5985096), "celestial": (16773808, 16763210),
    "corruption": (8114490, 4004434),
}

SOUL = "minecraft:soul_fire_flame"
SIG = {}

# ------------------------------------------------------------------------------------------------ Rage
SIG["rage"] = {
    1: {
        "all": [sh("crack3_0", "k", at=LEVEL), sh("streak16", "a", 0.4), gof("trail", 24)],
        0: [go("sigil3", 10, 12, at=f"{LEVEL} positioned ~ ~0.05 ~"), sh("cone4", "e", at=EYE), sh("fount32", "c", 0.35)],
        1: [go("rise", 14, 40, 0.9, at=LEVEL), sh("cyl1_5", "d", at=LEVEL), sh("burst32", "a", 0.5), raw("helix6", "minecraft:flame")],
        2: [sh("crack8_1", "k", at=GROUND), sh("line16", "d", at=FEET_FWD(0)), raw("zap16_0", "minecraft:flame", at=f"positioned ^ ^0.2 ^ {GROUND}"),
            sh("fount64", "c", 0.45), go("ripple", 6, 0, at=LEVEL)],
    },
    2: {
        "all": [go("sigil5", 16, -8, at=LEVEL), gof("charge", 12, 41)],
        0: [sh("implode4", "a", 0.4, at="positioned ~ ~1 ~"), go("ripple", 9, 0, at=LEVEL), sh("skull2", "k", at=f"{FWD(2)}")],
        1: [sh("cyl2", "d", at=LEVEL), raw("helix10", "minecraft:flame", at=LEVEL), sh("crown3", "t", at=LEVEL), go("rise", 12, 30, 1.2, at=LEVEL)],
        2: [sh("heart1", "k", at=f"{EYE} positioned ^ ^-0.4 ^1.2"), sh("burst64", "c", 0.3, at="positioned ~ ~1.1 ~"), sh("sphere1", "d", at="positioned ~ ~1 ~")],
    },
    3: {
        "all": [gof("orbit", 40, 30), sh("crown1", "d", at=LEVEL), sh("ring1_5", "b", at="positioned ~ ~0.1 ~")],
        0: [sh("arc3", "d", at=f"{EYE} positioned ^ ^-0.3 ^0.5"), sh("arc2", "t", at=f"{EYE} positioned ^ ^-0.1 ^0.8"), gof("charge", 16, 55)],
        1: [go("sigil3", 40, 5, at=f"{LEVEL} positioned ~ ~0.05 ~"), sh("dome2", "e"), sh("crown3", "k", at=LEVEL)],
        2: [go("spiral", 20, 36, at=LEVEL), sh("arc4", "d", at=f"positioned ~ ~1 ~ {LEVEL}"), sh("arc4", "t", at="positioned ~ ~1 ~ rotated 180 0"),
            sh("streak24", "a", 0.5)],
    },
    4: {
        "all": [col(C["rage"][0]), go("sigil7", 24, 6, at=LEVEL), go("nova", 6, at="positioned ~ ~1 ~"), gof("charge", 60, 37),
                gof("halo", 200), sh("crown5", "k", at=LEVEL), sh("crack8_0", "k", at=LEVEL), go("ripple", 12, at=LEVEL)],
        0: [sh("skull4", "d", at=f"{EYE} positioned ^ ^1 ^4"), raw("vortex10", "minecraft:flame", at=LEVEL)],
        1: [go("rise", 18, 45, 1.4, at=LEVEL), sh("cyl3", "d", at=LEVEL), raw("bolt1", "minecraft:flame", at="positioned ~ ~0.1 ~")],
        2: [sh("heart2", "k", at=f"{EYE} positioned ^ ^0.4 ^2.5"), raw("crack8_2", "minecraft:lava", at=LEVEL), sh("fangs4", "k", at=LEVEL)],
    },
}

# ------------------------------------------------------------------------------------------------ Speed
SIG["speed"] = {
    1: {
        "all": [sh("streak24", "a", 0.6), sh("ring1_5", "b", at="positioned ~ ~0.1 ~"), gof("trail", 14)],
        0: [sh("braid16", "d", at=EYE), sh("line16", "b", at=EYE), raw("zap16_1", "minecraft:electric_spark", at=EYE), sh("tube12", "e", at=EYE)],
        1: [sh("arc4", "d", at=f"{EYE} rotated ~ ~-40"), raw("arc3", "minecraft:end_rod", at=f"{EYE} rotated ~ ~-55"), go("rise", 10, 50, 0.8, at=LEVEL)],
        2: [sh("braid8", "d", at=f"{EYE} rotated ~180 0"), go("clock", 30, 24, at=f"{LEVEL} positioned ~ ~0.05 ~"), sh("arc2", "t", at=f"{LEVEL} positioned ~ ~0.6 ~")],
    },
    2: {
        "all": [sh("sphere1", "t", at="positioned ~ ~1 ~"), sh("burst32", "b", 0.3, at="positioned ~ ~1 ~"), raw("cyl1", "minecraft:electric_spark", at=LEVEL)],
        0: [sh("implode2", "a", 0.25, at="positioned ~ ~1 ~"), go("ripple", 5, at=LEVEL)],
        1: [sh("line24", "d", at=FEET_FWD(0)), sh("braid24", "e", at=f"positioned ~ ~1 ~ {GROUND}")],
        2: [sh("eye1", "d", at=f"{EYE} positioned ^ ^ ^1.5"), sh("ring3", "k", at="positioned ~ ~0.05 ~")],
    },
    3: {
        "all": [gof("trail", 80), gof("orbit", 60, 45), sh("streak24", "a", 0.5)],
        0: [sh("spiral3", "d", at=LEVEL), sh("tube8", "e", at=f"positioned ~ ~1 ~ {GROUND}")],
        1: [sh("cone6", "t", at=f"{EYE} rotated ~180 ~"), raw("braid24", "minecraft:flame", at=EYE), sh("burst64", "a", 0.6)],
        2: [go("vortex", 60, 28, at=LEVEL), go("spiral", 60, 40, at=LEVEL)],
    },
    4: {
        "all": [go("clock", 80, 18, at=f"{LEVEL} positioned ~ ~0.05 ~"), go("sigil7", 30, -4, at=LEVEL), gof("orbit", 100, 22),
                sh("clock8", "e", at=f"{LEVEL} positioned ~ ~3 ~"), sh("sphere3", "t", at="positioned ~ ~1 ~"), go("ripple", 10, at=LEVEL)],
        0: [sh("dome5", "d"), col(C["speed"][1]), sh("dome5", "e"), sh("star8_5", "d", at=LEVEL)],
        1: [sh("implode6", "a", 0.6, at="positioned ~ ~1 ~"), go("nova", 6, at="positioned ~ ~1 ~"), sh("star8_3", "d", at=LEVEL)],
        2: [gof("halo", 160), sh("dome3", "d"), col(C["speed"][1]), gof("charge", 160, 33)],
    },
}

# ------------------------------------------------------------------------------------------------ Infernal
SIG["infernal"] = {
    1: {
        "all": [sh("implode2", "a", 0.25, at=f"{EYE} positioned ^ ^ ^1"), sh("cone6", "d", at=EYE), sh("conefill6", "a", at=EYE),
                raw("ring1", "minecraft:lava", at="positioned ~ ~0.1 ~")],
        0: [sh("arc3", "t", at=f"{EYE} positioned ^ ^-0.3 ^0.6"), raw("braid8", "minecraft:flame", at=EYE)],
        1: [sh("cone4", "k", at=f"{EYE} rotated ~ ~-35"), sh("fount32", "c", 0.3)],
        2: [go("spiral", 16, 50, at=LEVEL), sh("ring3", "d", at="positioned ~ ~0.8 ~"), sh("streak24", "a", 0.5, at="positioned ~ ~0.6 ~")],
    },
    2: {
        "all": [go("sigil3", 12, 9, at=f"{LEVEL} positioned ~ ~0.05 ~"), sh("streak16", "a", 0.45), raw("cyl1_5", "minecraft:flame", at=LEVEL)],
        0: [sh("line8", "d", at=f"{FEET_FWD(3)} rotated ~90 0"), sh("line8", "d", at=f"{FEET_FWD(3)} rotated ~-90 0"),
            sh("crown1", "t", at=FEET_FWD(3))],
        1: [go("ripple", 10, at=f"{LEVEL} positioned ^ ^ ^2"), sh("arc6", "d", at=GROUND), sh("arc4", "k", at=GROUND)],
        2: [sh("line16", "k", at=FEET_FWD(0)), sh("tube16", "d", at=f"positioned ~ ~0.4 ~ {GROUND}"), raw("line16", "minecraft:lava", at=FEET_FWD(0))],
    },
    3: {
        "all": [sh("fangs2", "k", at=FWD(6)), sh("crack5_0", "k", at=f"{FWD(6)} {LEVEL}"), go("sigil5", 20, 7, at=f"{FWD(6)} {LEVEL}")],
        0: [go("vortex", 20, 30, at=f"{FWD(6)} {LEVEL}")],
        1: [sh("dome3", "d", at=FWD(5)), go("bolts", 18, 137, at=f"{FWD(5)} {LEVEL}")],
        2: [go("rise", 16, 33, 1.0, at=LEVEL), raw("vortex6", "minecraft:flame", at=LEVEL), sh("fount64", "c", 0.5)],
    },
    4: {
        "all": [go("sigil7", 30, 6, at=LEVEL), go("vortex", 40, 24, at=LEVEL), gof("charge", 200, 29), gof("halo", 200),
                sh("fangs4", "k", at=LEVEL), raw("helix16", "minecraft:flame", at=LEVEL), go("nova", 6, at="positioned ~ ~1 ~")],
        0: [raw("crown5", "minecraft:flame", at=LEVEL), sh("ring8", "t", at="positioned ~ ~0.2 ~")],
        1: [go("rise", 24, 25, 0.6, at=LEVEL), raw("cyl3", SOUL, at=LEVEL)],
        2: [sh("implode8", "a", 0.6, at="positioned ~ ~1 ~"), sh("sphere3", "k", at="positioned ~ ~1 ~"), col(C["infernal"][1]),
            go("ripple", 14, at=LEVEL), sh("star8_7", "d", at=LEVEL)],
    },
}

# ------------------------------------------------------------------------------------------------ Void
SIG["void"] = {
    1: {
        "all": [sh("implode2", "a", 0.3, at="positioned ~ ~1 ~"), sh("galaxy3", "d", at=f"{LEVEL} positioned ~ ~0.05 ~"), sh("sphere1", "k", at="positioned ~ ~1 ~")],
        0: [sh("braid8", "e", at=EYE), sh("eye1", "d", at=f"{EYE} positioned ^ ^ ^1.2")],
        1: [go("rise", 12, 40, 0.7, at=LEVEL), sh("dome2", "k")],
        2: [sh("eye1", "k", at=f"{EYE} rotated ~180 0 positioned ^ ^ ^1"), go("spiral", 16, -40, at=LEVEL)],
    },
    2: {
        "all": [sh("implode3", "a", 0.3, at=f"{EYE} positioned ^ ^ ^2"), sh("galaxy3", "d", at=f"{EYE} positioned ^ ^ ^2"), raw("sphere1_5", "minecraft:squid_ink", at=f"{EYE} positioned ^ ^ ^2")],
        0: [sh("tube16", "e", at=EYE)],
        1: [sh("braid24", "d", at=EYE), sh("line24", "b", at=EYE)],
        2: [go("sigil3", 24, -9, at=f"{FWD(1.5)} {LEVEL}"), sh("eye1", "k", at=f"{LEVEL} positioned ~ ~0.2 ~")],
    },
    3: {
        "all": [sh("braid16", "d", at=EYE), sh("line16", "b", at=EYE), sh("sphere1", "k", at="positioned ~ ~1 ~"), go("spiral", 12, -45, at=LEVEL)],
        0: [sh("eye2", "d", at=f"{EYE} positioned ^ ^ ^3")],
        1: [sh("implode4", "a", 0.45, at="positioned ~ ~1 ~"), sh("galaxy3", "k", at=f"{LEVEL} positioned ~ ~0.05 ~")],
        2: [go("sigil3", 30, 12, at=f"{FWD(8)} {LEVEL}"), sh("crack3_1", "k", at=f"{FWD(8)} {LEVEL}")],
    },
    4: {
        "all": [go("sigil7", 30, -5, at=LEVEL), gof("orbit", 120, -26), sh("galaxy6", "d", at=f"{LEVEL} positioned ~ ~0.05 ~"),
                sh("implode8", "a", 0.7, at="positioned ~ ~1 ~"), sh("eye4", "k", at=f"{EYE} positioned ^ ^1 ^6")],
        0: [go("spiral", 60, -30, at=f"{FWD(10)} {LEVEL}"), go("vortex", 60, -26, at=f"{FWD(10)} {LEVEL}"), sh("sphere3", "k", at=FWD(10))],
        1: [gof("halo", 120), go("vortex", 40, -30, at=f"{LEVEL} positioned ~ ~2 ~"), sh("sphere2", "k", at="positioned ~ ~3 ~")],
        2: [go("nova", 6, at="positioned ~ ~1 ~"), sh("implode8", "b", 0.8, at="positioned ~ ~1 ~"), col(C["void"][1]), go("ripple", 15, at=LEVEL),
            sh("dome8", "d")],
    },
}

# ------------------------------------------------------------------------------------------------ Frozen
SIG["frozen"] = {
    1: {
        "all": [sh("flake2", "d", at=f"{EYE} positioned ^ ^ ^1.5 rotated ~ ~-90"), sh("burst16", "a", 0.2, at=f"{EYE} positioned ^ ^ ^1.5")],
        0: [sh("line16", "b", at=EYE), sh("braid16", "e", at=EYE), sh("tube8", "d", at=EYE)],
        1: [sh("flake4", "d", at=f"{FWD(8)} {LEVEL}"), sh("ring4", "b", at=f"{FWD(8)} {LEVEL}"), go("sigil3", 20, 10, at=f"{FWD(8)} {LEVEL}")],
        2: [sh("flake2", "t", at=f"{LEVEL} positioned ~ ~0.05 ~"), gof("trail", 10), sh("sphere1", "d", at="positioned ~ ~1 ~")],
    },
    2: {
        "all": [sh("flake4", "d", at=f"{LEVEL} positioned ~ ~0.05 ~"), sh("streak16", "a", 0.35)],
        0: [sh("hex3", "b", at=f"{FEET_FWD(3)}"), sh("crown1", "t", at=FEET_FWD(3)), sh("line8", "d", at=f"{FEET_FWD(3)} rotated ~90 0"),
            sh("line8", "d", at=f"{FEET_FWD(3)} rotated ~-90 0")],
        1: [sh("line16", "d", at=FEET_FWD(0)), go("ripple", 8, at=f"{LEVEL} positioned ^ ^ ^2")],
        2: [sh("crown3", "t", at=LEVEL), sh("hex5", "d", at=LEVEL), sh("dome3", "e")],
    },
    3: {
        "all": [sh("flake6", "d", at=f"{LEVEL} positioned ~ ~0.05 ~"), go("nova", 6, at="positioned ~ ~1 ~"), go("ripple", 8, at=LEVEL)],
        0: [sh("streak24", "a", 0.6), sh("crown3", "t", at=LEVEL)],
        1: [go("rise", 10, 40, 0.8, at=LEVEL), sh("star6_5", "b", at=LEVEL)],
        2: [sh("inring6", "a", 0.6), go("sigil5", 20, -12, at=LEVEL), sh("implode6", "b", 0.5, at="positioned ~ ~1 ~")],
    },
    4: {
        "all": [go("sigil7", 40, 5, at=LEVEL), go("vortex", 60, 20, at=LEVEL), sh("flake6", "t", at=f"{LEVEL} positioned ~ ~6 ~"),
                gof("halo", 200), sh("crown5", "d", at=LEVEL), sh("dome8", "e")],
        0: [sh("flake6", "d", at=f"{LEVEL} positioned ~ ~0.05 ~"), go("bolts", 30, 137, at=LEVEL)],
        1: [gof("orbit", 200, 30), gof("charge", 200, 25)],
        2: [sh("implode8", "a", 0.8, at="positioned ~ ~1 ~"), go("nova", 6, at="positioned ~ ~1 ~"), sh("star6_7", "d", at=LEVEL),
            col(C["frozen"][1]), sh("crack8_0", "d", at=LEVEL)],
    },
}

# ------------------------------------------------------------------------------------------------ Storm
SIG["storm"] = {
    1: {
        "all": [raw("zap8_0", "minecraft:electric_spark", at=EYE), sh("burst16", "a", 0.3, at="positioned ~ ~1.2 ~")],
        0: [sh("bolt0", "b", at=FWD(10)), sh("bolt2", "d", at=FWD(10)), go("sigil3", 14, 20, at=f"{FWD(10)} {LEVEL}")],
        1: [sh("bolt1", "b", at="positioned ~ ~0.1 ~"), sh("bolt3", "d", at="positioned ~ ~0.1 ~"), go("nova", 6, at="positioned ~ ~1 ~")],
        2: [raw("zap16_2", "minecraft:electric_spark", at=f"positioned ^ ^0.2 ^ {GROUND}"), sh("zap16_0", "d", at=f"positioned ^ ^0.3 ^ {GROUND}"),
            sh("line16", "b", at=FEET_FWD(0))],
    },
    2: {
        "all": [go("ripple", 9, at=LEVEL), sh("streak24", "c", 0.6), sh("vortex6", "e", at=LEVEL)],
        0: [go("vortex", 14, 40, at=LEVEL), sh("dome3", "d")],
        1: [go("vortex", 30, 45, at=f"{FWD(8)} {LEVEL}"), sh("cyl2", "b", at=f"{FWD(8)} {LEVEL}")],
        2: [sh("implode4", "a", 0.6, at="positioned ~ ~4 ~"), sh("crack5_2", "d", at=LEVEL), go("bolts", 9, 137, at=LEVEL)],
    },
    3: {
        "all": [sh("zap16_1", "b", at=EYE), raw("zap16_2", "minecraft:electric_spark", at=EYE), gof("charge", 12, 60)],
        0: [sh("tube12", "e", at=EYE)],
        1: [sh("sphere1_5", "d", at=FWD(3)), sh("burst32", "a", 0.3, at=FWD(3))],
        2: [go("sigil5", 30, 15, at=LEVEL), sh("ring6", "b", at="positioned ~ ~1 ~"), sh("streak24", "a", 0.7, at="positioned ~ ~1 ~")],
    },
    4: {
        "all": [go("bolts", 60, 137, at=LEVEL), go("sigil7", 30, 9, at=LEVEL), gof("orbit", 200, 40), sh("vortex10", "e", at=LEVEL),
                raw("dome8", "minecraft:cloud", at="positioned ~ ~8 ~"), sh("bolt0", "b"), sh("bolt2", "b")],
        0: [gof("charge", 200, 45), gof("halo", 200)],
        1: [go("vortex", 80, 35, at=LEVEL), go("spiral", 80, 30, at=LEVEL)],
        2: [sh("implode8", "a", 0.8, at="positioned ~ ~1 ~"), go("nova", 6, at="positioned ~ ~1 ~"), sh("cyl2", "b", at=LEVEL)],
    },
}

# ------------------------------------------------------------------------------------------------ Blood
SIG["blood"] = {
    1: {
        "all": [sh("heart1", "d", at=f"{EYE} positioned ^ ^ ^1.4"), sh("implode2", "a", 0.2, at=f"{EYE} positioned ^ ^ ^1.4")],
        0: [sh("braid12", "d", at=EYE), sh("line12", "k", at=EYE)],
        1: [go("sigil5", 26, -8, at=f"{FWD(9)} {LEVEL}"), sh("ring5", "b", at=f"{FWD(9)} {LEVEL} positioned ~ ~4 ~")],
        2: [sh("line12", "d", at=FEET_FWD(0)), sh("crack5_2", "k", at=f"{FEET_FWD(4)}"), sh("fangs2", "k", at=FEET_FWD(5))],
    },
    2: {
        "all": [sh("heart2", "k", at=f"{EYE} positioned ^ ^-0.3 ^1.6"), sh("burst64", "a", 0.35, at="positioned ~ ~1.2 ~"), gof("charge", 20, 40)],
        0: [sh("crown1", "d", at=LEVEL), gof("halo", 160)],
        1: [sh("dome2", "d"), sh("sphere1_5", "k", at="positioned ~ ~1 ~")],
        2: [go("sigil5", 12, 10, at=LEVEL), sh("inring4", "a", 0.4), go("nova", 6, at="positioned ~ ~1 ~")],
    },
    3: {
        "all": [sh("braid12", "d", at=EYE), sh("zap8_1", "k", at=EYE), gof("orbit", 80, 30)],
        0: [sh("heart1", "t", at=f"{EYE} positioned ^ ^ ^3")],
        1: [sh("line16", "k", at=EYE), sh("implode2", "a", 0.3, at="positioned ~ ~1 ~")],
        2: [sh("implode6", "a", 0.6, at="positioned ~ ~1 ~"), go("sigil7", 14, -10, at=LEVEL)],
    },
    4: {
        "all": [go("sigil7", 40, 4, at=LEVEL), sh("sphere2", "d", at="positioned ~ ~9 ~"), sh("sphere1_5", "k", at="positioned ~ ~9 ~"),
                sh("ring6", "t", at="positioned ~ ~9 ~"), go("spiral", 40, 20, at=LEVEL), gof("charge", 240, 23), sh("heart4", "d", at=f"{EYE} positioned ^ ^2 ^5")],
        0: [gof("halo", 240), go("ripple", 13, at=LEVEL)],
        1: [sh("dome8", "k"), sh("rune7", "b", at=LEVEL)],
        2: [go("sigil5", 30, -12, at=f"{FWD(10)} {LEVEL}"), sh("sphere3", "k", at=f"{FWD(10)} positioned ~ ~10 ~"), sh("implode8", "a", 0.6, at=FWD(10))],
    },
}

# ------------------------------------------------------------------------------------------------ Titan
SIG["titan"] = {
    1: {
        "all": [sh("crack5_0", "k", at=LEVEL), sh("fount32", "a", 0.4), raw("streak24", "minecraft:cloud", 0.3)],
        0: [sh("crack8_1", "k", at=f"{FEET_FWD(4)}"), sh("line16", "d", at=FEET_FWD(0)), sh("fangs2", "a", at=FEET_FWD(6))],
        1: [go("rise", 12, 30, 0.9, at=LEVEL), go("sigil5", 30, 6, at=f"{FWD(8)} {LEVEL}")],
        2: [go("ripple", 10, at=LEVEL), sh("fangs4", "k", at=LEVEL), sh("crack8_2", "k", at=LEVEL)],
    },
    2: {
        "all": [sh("hex2", "d", at=LEVEL), sh("cyl1_5", "e", at=LEVEL), sh("sphere1_5", "c", at="positioned ~ ~1 ~")],
        0: [gof("halo", 160), sh("crown1", "a", at=LEVEL)],
        1: [col(1052688), sh("dome2", "d"), sh("sphere1", "k", at="positioned ~ ~1 ~"), col(C["titan"][0])],
        2: [sh("fangs4", "k", at=LEVEL), go("ripple", 6, at=LEVEL)],
    },
    3: {
        "all": [sh("crack3_2", "k", at=LEVEL), sh("fount32", "a", 0.45), sh("implode2", "c", 0.3, at="positioned ~ ~1.5 ~")],
        0: [sh("arc4", "d", at=f"{EYE} rotated ~ ~-30")],
        1: [go("sigil5", 30, 8, at=f"{FWD(10)} {LEVEL}"), sh("crack5_1", "k", at=f"{FWD(10)} {LEVEL}")],
        2: [sh("cone6", "d", at=EYE), sh("conefill6", "a", at=EYE)],
    },
    4: {
        "all": [go("sigil7", 30, 3, at=LEVEL), sh("fangs6", "k", at=LEVEL), sh("crack8_0", "k", at=LEVEL), go("ripple", 14, at=LEVEL),
                sh("cyl4", "e", at=LEVEL), sh("fount64", "a", 0.6), raw("dome8", "minecraft:cloud"), gof("halo", 200)],
        0: [sh("crown5", "d", at=LEVEL)],
        1: [go("rise", 14, 20, 1.2, at=LEVEL), go("sigil7", 40, -4, at=f"{FWD(12)} {LEVEL}")],
        2: [sh("hex7", "d", at=LEVEL), sh("star6_7", "t", at=LEVEL), gof("charge", 200, 15)],
    },
}

# ------------------------------------------------------------------------------------------------ Celestial
SIG["celestial"] = {
    1: {
        "all": [sh("star5_2", "d", at=f"{EYE} positioned ^ ^ ^1.5 rotated ~ ~-90"), sh("burst16", "b", 0.2, at=f"{EYE} positioned ^ ^ ^1.5")],
        0: [go("sigil3", 16, 14, at=f"{FWD(10)} {LEVEL}"), sh("cyl1", "e", at=f"{FWD(10)} {LEVEL}")],
        1: [go("sigil5", 30, 9, at=f"{FWD(8)} {LEVEL}"), sh("star5_5", "t", at=f"{FWD(8)} {LEVEL}")],
        2: [sh("star5_3", "d", at=LEVEL), sh("cyl1_5", "b", at=LEVEL), go("nova", 6, at="positioned ~ ~1 ~")],
    },
    2: {
        "all": [go("sigil5", 60, 3, at=LEVEL), gor("wings", 40), sh("dome5", "e")],
        0: [sh("star8_5", "t", at=LEVEL), raw("helix6", "minecraft:end_rod", at=LEVEL)],
        1: [sh("dome3", "d"), sh("sphere3", "b", at="positioned ~ ~1 ~")],
        2: [sh("star5_5", "k", at=LEVEL), sh("ring5", "d", at="positioned ~ ~0.1 ~")],
    },
    3: {
        "all": [gof("charge", 8, 60), sh("implode3", "a", 0.3, at=f"{EYE} positioned ^ ^ ^1")],
        0: [sh("braid24", "d", at=EYE), sh("tube24", "e", at=EYE), sh("line24", "b", at=EYE)],
        1: [sh("braid32", "d", at=EYE), gof("halo", 50)],
        2: [go("sigil5", 20, 12, at=LEVEL), sh("star8_5", "d", at=LEVEL), sh("star8_3", "b", at=f"{LEVEL} positioned ~ ~1 ~")],
    },
    4: {
        "all": [go("sigil7", 40, 4, at=LEVEL), gor("wings", 240), gof("halo", 240), go("nova", 6, at="positioned ~ ~1 ~"),
                sh("star8_7", "t", at=LEVEL), raw("cyl3", "minecraft:end_rod", at=LEVEL), sh("burst64", "b", 0.5, at="positioned ~ ~2 ~")],
        0: [go("rise", 20, 30, 0.4, at=LEVEL)],
        1: [go("rise", 24, 30, 0.7, at=LEVEL), sh("star5_7", "d", at=f"{LEVEL} positioned ~ ~0.1 ~")],
        2: [gof("orbit", 240, 24), sh("dome8", "e")],
    },
}

# ------------------------------------------------------------------------------------------------ Corruption
SIG["corruption"] = {
    1: {
        "all": [sh("implode2", "a", 0.2, at=f"{EYE} positioned ^ ^ ^1"), sh("skull1", "d", at=f"{EYE} positioned ^ ^ ^1.4")],
        0: [sh("braid16", "d", at=EYE), sh("line16", "c", at=EYE)],
        1: [sh("arc4", "k", at=f"{EYE} rotated ~ ~-40"), sh("fount32", "a", 0.3)],
        2: [sh("cone4", "d", at=EYE), sh("conefill4", "a", at=EYE), sh("conefill4", "c", at=EYE)],
    },
    2: {
        "all": [go("sigil5", 24, -6, at=f"{FWD(1)} {LEVEL}"), sh("crack5_0", "k", at=LEVEL)],
        0: [go("spiral", 30, 18, at=f"{FWD(8)} {LEVEL}"), sh("skull2", "d", at=f"{FWD(8)} positioned ~ ~1.5 ~")],
        1: [gof("halo", 160), gof("orbit", 160, -24), sh("dome3", "k")],
        2: [sh("fangs4", "k", at=LEVEL), sh("inring4", "a", 0.4), go("ripple", 8, at=LEVEL)],
    },
    3: {
        "all": [sh("zap8_2", "d", at=EYE), sh("skull1", "k", at=f"{EYE} positioned ^ ^ ^3")],
        0: [sh("sphere1", "d", at=FWD(4))],
        1: [gof("charge", 80, 35), sh("skull2", "d", at=f"{EYE} positioned ^ ^0.6 ^1.4")],
        2: [sh("braid16", "k", at=EYE), gof("orbit", 80, 28)],
    },
    4: {
        "all": [go("sigil7", 40, -3, at=LEVEL), sh("skull4", "d", at=f"{EYE} positioned ^ ^1.5 ^5"), sh("crack8_1", "k", at=LEVEL),
                go("ripple", 18, at=LEVEL), gof("halo", 160), sh("implode8", "a", 0.6, at="positioned ~ ~1 ~")],
        0: [sh("fangs6", "k", at=LEVEL), go("spiral", 40, -22, at=LEVEL)],
        1: [raw("dome8", "minecraft:squid_ink", at="positioned ~ ~6 ~"), go("vortex", 80, -20, at=f"{LEVEL} positioned ~ ~3 ~"), sh("galaxy6", "d", at=f"{LEVEL} positioned ~ ~9 ~")],
        2: [sh("fangs6", "d", at=LEVEL), sh("crown5", "k", at=LEVEL), go("nova", 6, at="positioned ~ ~1 ~")],
    },
}


def write_signatures(fn, types):
    """fn(rel, lines) writes a function. Returns the number of signature functions written."""
    count = 0
    disp = ["# Generated: plays the signature VFX of the ability just cast (see tools/vfx_signatures.py)."]
    for i, h, *_ in types:
        disp.append(f"execute if score @s ch.active matches {i} run return run function ch:gen/sig/{h}")
        lines = [f"# Generated: {h} signature VFX by slot (#sig_s ch.tmp).", col(C[h][0])]
        for s in (1, 2, 3, 4):
            lines.append(f"execute if score #sig_s ch.tmp matches {s} run return run function ch:gen/sig/{h}_a{s}")
            ent = SIG[h][s]
            body = [f"# Generated: signature VFX of {h} ability {s}; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).",
                    col(C[h][0])]
            body += ent.get("all", [])
            for v in (0, 1, 2):
                vl = ent.get(v, [])
                if vl:
                    fn(f"gen/sig/{h}_a{s}_v{v}", [f"# Generated: {h} ability {s}, variant {v}.", col(C[h][0])] + vl)
                    body.append(f"execute if score #sig_v ch.tmp matches {v} run function ch:gen/sig/{h}_a{s}_v{v}")
                    count += 1
            fn(f"gen/sig/{h}_a{s}", body)
            count += 1
        fn(f"gen/sig/{h}", lines)
    fn("gen/vfx_sig", disp)
    return count


def extra_colors():
    """Colours the signatures switch to, mapped to their heart for the theme table."""
    out = {c: h for h, pair in C.items() for c in pair}
    out[1052688] = "titan"
    return out
