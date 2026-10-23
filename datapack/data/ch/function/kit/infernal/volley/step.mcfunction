# Fireball flight: dense trail, Seeking Flame curve and the mortar arc.
execute if entity @s[tag=ch.infernal.arc] run tp @s ~ ~ ~ ~ ~4
execute if score @s ch.v5 matches 1.. run function ch:kit/infernal/volley/seek
execute if score @s ch.v6 matches 1 run particle minecraft:soul_fire_flame ~ ~ ~ 0.08 0.08 0.08 0.015 3
execute unless score @s ch.v6 matches 1 run particle minecraft:flame ~ ~ ~ 0.08 0.08 0.08 0.015 3
execute if score @s ch.v6 matches 1 run particle minecraft:dust{color:[0.25,0.88,0.91],scale:1.4} ~ ~ ~ 0.1 0.1 0.1 0 2
execute unless score @s ch.v6 matches 1 run particle minecraft:dust{color:[1.0,0.48,0.1],scale:1.4} ~ ~ ~ 0.1 0.1 0.1 0 2
particle minecraft:small_flame ~ ~ ~ 0.12 0.12 0.12 0.01 1
particle minecraft:smoke ~ ~ ~ 0.05 0.05 0.05 0.01 1
execute if score @s ch.v4 matches 1 run particle minecraft:lava ~ ~ ~ 0.1 0.1 0.1 0 1
execute if score @s ch.v4 matches 1 run particle minecraft:large_smoke ~ ~ ~ 0.2 0.2 0.2 0.01 2
scoreboard players operation #i_p ch.tmp = @s ch.life
scoreboard players operation #i_p ch.tmp %= #2 ch.g
execute if score #i_p ch.tmp matches 0 run function ch:kit/infernal/volley/ghost
