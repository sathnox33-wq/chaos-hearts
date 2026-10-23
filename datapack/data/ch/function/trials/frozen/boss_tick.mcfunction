# Hrimvald, every tick: decorations, his ice hazards, the blizzard and the attack cycle of the current phase.
tag @s add ch.frozen.bself
scoreboard players add @s ch.frozen.bt 1
execute as @e[type=item_display,tag=ch.frozen.bdeco,distance=..60] run function ch:trials/frozen/deco
execute as @e[type=marker,tag=ch.frozen.tline,distance=..90] at @s run function ch:trials/frozen/line_tick
scoreboard players operation #fb ch.tmp = @s ch.frozen.bt
scoreboard players operation #fb ch.tmp %= #4 ch.g
execute if score #fb ch.tmp matches 0 run particle minecraft:snowflake ~ ~3 ~ 0.7 1.4 0.7 0.02 6
execute if score @s ch.frozen.ph matches 3.. run scoreboard players set @s ch.frozen.zero 20
execute if score @s ch.frozen.zero matches 1.. run function ch:trials/frozen/blizzard
execute if score @s ch.frozen.ph matches ..1 run function ch:trials/frozen/cycle1
execute if score @s ch.frozen.ph matches 2 run function ch:trials/frozen/cycle2
execute if score @s ch.frozen.ph matches 3.. run function ch:trials/frozen/cycle3
tag @s remove ch.frozen.bself
