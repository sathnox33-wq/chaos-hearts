# A falling meteor.
scoreboard players remove @s ch.v1 1
tp @s ~ ~-2 ~
particle minecraft:flame ~ ~1 ~ 0.5 0.5 0.5 0.06 10
particle minecraft:large_smoke ~ ~2 ~ 0.4 0.8 0.4 0.02 4
particle minecraft:lava ~ ~1 ~ 0.3 0.3 0.3 0 1
execute if score @s ch.v1 matches ..0 at @s run function ch:trials/infernal/met_hit
