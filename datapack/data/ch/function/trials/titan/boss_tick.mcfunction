# Golgoth's mind, every tick: decorations, fault lines, the held boulder, and its attack patterns.
tag @s add ch.caster
scoreboard players add @s ch.t 1
function ch:trials/titan/deco
execute if entity @e[type=marker,tag=ch.titan.tf,distance=..80,limit=1] as @e[type=marker,tag=ch.titan.tf,distance=..80] at @s run function ch:trials/titan/tf_step
execute as @e[type=block_display,tag=ch.titan.brock,distance=..20] positioned ~ ~6.5 ~ run tp @s ~ ~ ~
execute if score @s ch.v6 matches 1.. run function ch:trials/titan/lock_tick
execute unless score @s ch.v6 matches 1.. run function ch:trials/titan/patterns
execute if score @s ch.v4 matches 1.. run function ch:trials/titan/skin_tick
execute if score #t20 ch.g matches 0 run particle minecraft:falling_dust{block_state:"minecraft:gravel"} ~ ~4 ~ 1 1.5 1 0 6
execute if score #t20 ch.g matches 10 run particle minecraft:lava ~ ~3 ~ 0.4 0.4 0.4 0 2
tag @s remove ch.caster
