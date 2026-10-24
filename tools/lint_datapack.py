#!/usr/bin/env python3
"""
Static checks for the Chaos Hearts datapack. Catches the mistakes that make Minecraft refuse a function file
(which then silently does nothing): unknown commands, broken macro lines, unbalanced brackets, missing functions,
unknown ids, undefined objectives and tags. It is not a full parser; the CI server log is the final word.

    python3 tools/lint_datapack.py [path-prefix ...]   # only report files under these prefixes
"""
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DP = os.path.join(ROOT, "datapack", "data")
REF = "/tmp/claude-0/ref/mc"
RP_SOUNDS = os.path.join(ROOT, "resourcepack", "assets", "chaoshearts", "sounds.json")

errors = []


def err(path, ln, msg):
    errors.append((os.path.relpath(path, ROOT), ln, msg))


def load_ref():
    cmds = reg = None
    try:
        cmds = json.load(open(os.path.join(REF, "commands.json")))
        reg = json.load(open(os.path.join(REF, "registries.json")))
    except OSError:
        pass
    return cmds, reg


CMDS, REG = load_ref()
TOP = set(CMDS["children"].keys()) if CMDS else None
EXEC_SUB = {"align", "anchored", "as", "at", "facing", "if", "in", "on", "positioned", "rotated", "store", "summon",
            "unless", "run"}
SEL_ARGS = {"x", "y", "z", "distance", "dx", "dy", "dz", "x_rotation", "y_rotation", "scores", "tag", "team", "name",
            "type", "predicate", "nbt", "gamemode", "level", "advancements", "limit", "sort"}


def reg(name):
    if not REG:
        return None
    v = REG.get(name)
    return set(v) if v else None


ENTITIES = reg("entity_type")
PARTICLES = reg("particle_type")
EFFECTS = reg("mob_effect")
ITEMS = reg("item")
BLOCKS = reg("block")
ATTRS = reg("attribute")
SOUNDS_VANILLA = reg("sound_event")
try:
    CH_SOUNDS = set(json.load(open(RP_SOUNDS)).keys())
except OSError:
    CH_SOUNDS = set()


def strip_ns(x):
    return x[10:] if x.startswith("minecraft:") else x


def collect():
    funcs, files = set(), []
    tags = {}
    for dirpath, _, names in os.walk(DP):
        for n in names:
            p = os.path.join(dirpath, n)
            rel = os.path.relpath(p, DP).replace(os.sep, "/")
            parts = rel.split("/")
            ns = parts[0]
            if len(parts) > 2 and parts[1] == "function" and n.endswith(".mcfunction"):
                funcs.add(f"{ns}:{'/'.join(parts[2:])[:-11]}")
                files.append(p)
            elif n.endswith(".json"):
                try:
                    json.load(open(p, encoding="utf-8"))
                except Exception as e:  # noqa: BLE001
                    err(p, 0, f"invalid JSON: {e}")
                if len(parts) > 3 and parts[1] == "tags":
                    kind = parts[2]
                    tags.setdefault(kind, set()).add(f"{ns}:{'/'.join(parts[3:])[:-5]}")
    return funcs, files, tags


def balanced(s):
    stack, q = [], None
    pairs = {"]": "[", "}": "{", ")": "("}
    i = 0
    while i < len(s):
        c = s[i]
        if q:
            if c == "\\":
                i += 2
                continue
            if c == q:
                q = None
        elif c in "\"'":
            # a quote only opens a string at a token boundary (keys, values); apostrophes inside words are text
            prev = s[i - 1] if i else " "
            if c == '"' or prev in " ,:[{(=":
                q = c
        elif c in "[{(":
            stack.append(c)
        elif c in "]})":
            if not stack or stack[-1] != pairs[c]:
                return False
            stack.pop()
        i += 1
    return not stack and q is None


VFX_SHAPE_RE = re.compile(r'\{s:"([a-z0-9_]+)"')
VFX_TL_RE = re.compile(r'f:"(ch:[a-z0-9_/]+)"')


def check_vfx_refs(p, ln, body, funcs):
    """Shape names passed to ch:vfx/sh and timeline functions passed to ch:vfx/go|gof|gor|play are only resolved
    inside macros, so the normal function check cannot see them."""
    if "ch:vfx/" not in body:
        return
    for m in VFX_SHAPE_RE.findall(body):
        if "ch:vfx/sh" in body and f"ch:gen/vfx/{m}" not in funcs:
            err(p, ln, f"unknown VFX shape {m}")
    for m in VFX_TL_RE.findall(body):
        if m not in funcs:
            err(p, ln, f"unknown VFX timeline {m}")


def main():
    only = [os.path.abspath(a) for a in sys.argv[1:]]
    funcs, files, tags = collect()
    objectives = set()
    obj_re = re.compile(r"scoreboard objectives add (\S+)")
    texts = {}
    for p in files:
        t = open(p, encoding="utf-8").read()
        texts[p] = t
        objectives.update(obj_re.findall(t))
    gen_dir = os.path.join(ROOT, "tools", "build_datapack.py")
    try:  # objectives the generator creates
        g = open(gen_dir, encoding="utf-8").read()
        for m in re.findall(r'"(ch\.[a-z0-9_.]+)"', g):
            objectives.add(m)
        for p_ in ["own", "cnt", "xp", "lvl", "awk", "asc", "pts", "tree", "feat", "best", "ret"]:
            for h in ["rage", "speed", "infernal", "void", "frozen", "storm", "blood", "titan", "celestial", "corruption"]:
                objectives.add(f"ch.{p_}.{h}")
        objectives.update({"ch.deaths", "ch.leave", "hearts", "cast", "chmenu", "ch.health"})
    except OSError:
        pass

    for p in files:
        if only and not any(p.startswith(o) for o in only):
            continue
        for ln, raw in enumerate(texts[p].split("\n"), 1):
            line = raw.strip()
            if not line or line.startswith("#"):
                continue
            is_macro = line.startswith("$")
            body = line[1:] if is_macro else line
            if is_macro and "$(" not in body:
                err(p, ln, "macro line without $(variable)")
            if not is_macro and "$(" in body:
                err(p, ln, "uses $(variable) but the line does not start with $")
            if not balanced(body):
                err(p, ln, "unbalanced brackets or quotes")
            check_line(p, ln, body, funcs, tags, objectives)
            check_vfx_refs(p, ln, body, funcs)
    for path, ln, msg in errors:
        print(f"{path}:{ln}: {msg}")
    print(f"{len(errors)} problem(s)")
    return 1 if errors else 0


def tokens_outside(s):
    """Split on spaces that are outside brackets and quotes."""
    out, cur, depth, q = [], "", 0, None
    for c in s:
        if q:
            cur += c
            if c == q:
                q = None
            continue
        if c in "\"'":
            q = c
        elif c in "[{(":
            depth += 1
        elif c in "]})":
            depth -= 1
        if c == " " and depth == 0:
            if cur:
                out.append(cur)
            cur = ""
        else:
            cur += c
    if cur:
        out.append(cur)
    return out


def check_command(p, ln, toks, funcs, tags, objectives):
    if not toks:
        return
    cmd = toks[0]
    if TOP and cmd not in TOP:
        err(p, ln, f"unknown command '{cmd}'")
        return
    if cmd == "execute":
        i = 1
        while i < len(toks):
            if toks[i] == "run":
                check_command(p, ln, toks[i + 1:], funcs, tags, objectives)
                return
            i += 1
        return
    if cmd == "return" and len(toks) > 1 and toks[1] == "run":
        check_command(p, ln, toks[2:], funcs, tags, objectives)
        return
    if cmd == "function" and len(toks) > 1:
        f = toks[1]
        if "$(" in f:
            return
        if f.startswith("#"):
            if f[1:] not in tags.get("function", set()):
                err(p, ln, f"unknown function tag {f}")
        elif f not in funcs:
            err(p, ln, f"unknown function {f}")
    if cmd == "schedule" and len(toks) > 3 and toks[1] == "function":
        if "$(" not in toks[2] and toks[2] not in funcs:
            err(p, ln, f"unknown function {toks[2]}")
    if cmd == "summon" and len(toks) > 1 and ENTITIES and "$(" not in toks[1]:
        if strip_ns(toks[1]) not in ENTITIES:
            err(p, ln, f"unknown entity type {toks[1]}")
    if cmd == "particle" and len(toks) > 1 and PARTICLES and "$(" not in toks[1]:
        pid = strip_ns(re.split(r"[{\[]", toks[1])[0])
        if pid not in PARTICLES:
            err(p, ln, f"unknown particle {toks[1]}")
    if cmd == "particle" and len(toks) > 8 and "$(" not in toks[8] and toks[8].startswith("-"):
        err(p, ln, "particle speed must not be negative")
    if cmd == "particle" and len(toks) > 9 and "$(" not in toks[9] and toks[9].startswith("-"):
        err(p, ln, "particle count must not be negative")
    if cmd == "effect" and len(toks) > 3 and toks[1] == "give" and EFFECTS and "$(" not in toks[3]:
        if strip_ns(toks[3]) not in EFFECTS:
            err(p, ln, f"unknown effect {toks[3]}")
    if cmd == "attribute" and len(toks) > 2 and ATTRS and "$(" not in toks[2]:
        if strip_ns(toks[2]) not in ATTRS:
            err(p, ln, f"unknown attribute {toks[2]}")
    if cmd == "playsound" and len(toks) > 1 and "$(" not in toks[1]:
        s = toks[1]
        if s.startswith("chaoshearts:"):
            if CH_SOUNDS and s[12:] not in CH_SOUNDS:
                err(p, ln, f"unknown sound {s}")
        elif SOUNDS_VANILLA and strip_ns(s) not in SOUNDS_VANILLA:
            err(p, ln, f"unknown sound {s}")
    if cmd in ("setblock", "fill") and BLOCKS:
        idx = 4 if cmd == "setblock" else 7
        if len(toks) > idx and "$(" not in toks[idx]:
            b = strip_ns(re.split(r"[\[{]", toks[idx])[0])
            if not b.startswith("#") and b not in BLOCKS:
                err(p, ln, f"unknown block {toks[idx]}")
    if cmd == "gamerule" and len(toks) > 1 and CMDS:
        if toks[1] not in CMDS["children"]["gamerule"]["children"]:
            err(p, ln, f"unknown gamerule {toks[1]}")
    if cmd == "scoreboard" and len(toks) > 3 and toks[1] == "players":
        objs = []
        if toks[2] in ("set", "add", "remove", "reset", "get", "enable") and len(toks) > 4:
            objs.append(toks[4])
        if toks[2] == "operation" and len(toks) > 6:
            objs += [toks[4], toks[7] if len(toks) > 7 else ""]
        for o in objs:
            if o and "$(" not in o and o not in objectives:
                err(p, ln, f"objective '{o}' is never created")


def check_line(p, ln, body, funcs, tags, objectives):
    for sel in re.findall(r"@[aesprn]\[([^\]]*(?:\[[^\]]*\][^\]]*)*)\]", body):
        for part in re.split(r",(?![^{]*\})", sel):
            if "=" in part:
                k = part.split("=", 1)[0].strip()
                if k and k not in SEL_ARGS:
                    err(p, ln, f"unknown selector argument '{k}'")
                if k == "type":
                    v = part.split("=", 1)[1].strip().lstrip("!")
                    if v.startswith("#"):
                        if v[1:] not in tags.get("entity_type", set()) and not v.startswith("#minecraft:"):
                            err(p, ln, f"unknown entity type tag {v}")
                    elif ENTITIES and "$(" not in v and strip_ns(v) not in ENTITIES:
                        err(p, ln, f"unknown entity type {v}")
                if k == "scores":
                    for o in re.findall(r"([a-zA-Z0-9_.]+)=", part.split("=", 1)[1]):
                        if o not in objectives:
                            err(p, ln, f"objective '{o}' is never created")
    for t in re.findall(r"#ch:([a-z0-9_/]+)", body):
        if not any(f"ch:{t}" in s for s in tags.values()):
            err(p, ln, f"unknown tag #ch:{t}")
    for f in re.findall(r"predicate ch:([a-z0-9_/]+)", body):
        if not os.path.exists(os.path.join(DP, "ch", "predicate", f + ".json")):
            err(p, ln, f"unknown predicate ch:{f}")
    for f in re.findall(r"item_modifier[/ ]ch:([a-z0-9_/]+)|item modify \S+ \S+ ch:([a-z0-9_/]+)", body):
        f = f[0] or f[1]
        if f and not os.path.exists(os.path.join(DP, "ch", "item_modifier", f + ".json")):
            err(p, ln, f"unknown item modifier ch:{f}")
    check_command(p, ln, tokens_outside(body), funcs, tags, objectives)


if __name__ == "__main__":
    sys.exit(main())
