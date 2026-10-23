# Up: the mortar lands with a blast - half its damage to everything within 3 blocks.
scoreboard players operation #cd ch.tmp = @s ch.v4
scoreboard players operation #cd ch.tmp /= #2 ch.g
scoreboard players operation #cnec ch.tmp = @s ch.v6
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3,limit=10] run function ch:kit/corruption/hurt
particle minecraft:explosion ~ ~ ~ 0.5 0.3 0.5 0 2
function ch:api/fx/wave {color:8114490,r:4.0,t:5}
function ch:api/fx/shake {s:2,t:5,r:10}
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.8 1.3
