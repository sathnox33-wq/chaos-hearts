# Walks the fold straight up in half blocks until the head would hit a ceiling.
scoreboard players remove #vrs ch.tmp 1
execute unless block ~ ~2.3 ~ #ch:passable run return run summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
scoreboard players add #vsteps ch.tmp 1
particle minecraft:dust{color:[0.541,0.235,1.0],scale:1.5} ~ ~1 ~ 0.25 0.1 0.25 0 3
particle minecraft:reverse_portal ~ ~1 ~ 0.2 0.2 0.2 0.02 2
execute if score #vnd ch.tmp matches 1 positioned ~ ~1 ~ run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.6] add ch.void.path
execute if score #vrs ch.tmp matches ..0 positioned ~ ~0.5 ~ run return run summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
execute positioned ~ ~0.5 ~ run function ch:kit/void/step/walkup
