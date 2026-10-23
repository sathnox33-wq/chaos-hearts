# Every half second: everything inside the eye is dragged toward its heart.
function ch:api/tag_owner
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=3..$(r)] run function ch:api/pull {s:0.3}
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r)] at @s run particle minecraft:cloud ~ ~0.5 ~ 0.3 0.2 0.3 0.05 3
playsound minecraft:entity.breeze.idle_air player @a ~ ~ ~ 1.5 0.5
tag @a remove ch.caster
