# Shadow step: count the distance the ray covered, then find a spot behind the target.
scoreboard players set #vsteps ch.tmp 30
scoreboard players operation #vsteps ch.tmp -= #rs ch.tmp
execute if score #vsteps ch.tmp matches ..2 run scoreboard players set #vsteps ch.tmp 2
tag @e[tag=ch.target,limit=1] add ch.void.sst
tag @e[tag=ch.target] remove ch.target
execute as @e[tag=ch.void.sst,limit=1] at @s run function ch:kit/void/step/behind
