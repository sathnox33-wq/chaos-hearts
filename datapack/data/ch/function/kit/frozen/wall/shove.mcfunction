# Caught where the ice rises (position = the wall): flung back from the caster, chilled.
execute positioned as @a[tag=ch.caster,limit=1] run function ch:api/push {s:0.9,y:0.35}
scoreboard players set #f_dmg ch.tmp 30
execute at @s run function ch:kit/frozen/hurt
function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:1}
