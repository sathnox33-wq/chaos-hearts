# A falling molten bomb, every tick.
scoreboard players remove @s ch.v1 1
tp @s ~ ~-1.75 ~
particle minecraft:flame ~ ~0.7 ~ 0.3 0.3 0.3 0.05 6
particle minecraft:large_smoke ~ ~1.2 ~ 0.3 0.5 0.3 0.02 3
particle minecraft:lava ~ ~0.7 ~ 0.2 0.2 0.2 0 1
execute if score @s ch.v1 matches ..0 at @s run function ch:kit/infernal/erupt/bomb_land
