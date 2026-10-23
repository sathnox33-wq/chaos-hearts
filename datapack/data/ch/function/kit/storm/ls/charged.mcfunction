# Charged ground: sparks dance on it and it shocks and slows whoever stands there.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
execute if score #t2 ch.storm.g matches 0 run particle minecraft:electric_spark ~ ~0.2 ~ 1.4 0.05 1.4 0.05 6
execute if score #t5 ch.storm.g matches 0 run function ch:api/fx/ring {p:"minecraft:dust{color:[0.31,0.66,1.0],scale:0.7}",r:2.5}
execute unless score #t10 ch.storm.g matches 0 run return 0
function ch:api/tag_owner
scoreboard players set #d ch.storm.g 10
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.6] at @s run function ch:kit/storm/ls/charged_one
tag @a remove ch.caster
