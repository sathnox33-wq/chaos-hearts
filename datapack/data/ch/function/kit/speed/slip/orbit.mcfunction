# As an enemy caught in the vortex.
execute positioned as @a[tag=ch.caster,limit=1] run function ch:api/pull {s:0.35}
function ch:kit/speed/fn/hit
function ch:api/cc {effect:"minecraft:slowness",sec:1,amp:1}
particle minecraft:cloud ~ ~1 ~ 0.3 0.4 0.3 0.05 5
