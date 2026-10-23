# Hanging at the apex; when it runs out a wind burst above slams you down.
scoreboard players remove @s ch.rage.hang 1
particle minecraft:dust{color:[0.88,0.15,0.17],scale:2.2} ~ ~1 ~ 0.5 0.6 0.5 0 6
particle minecraft:soul_fire_flame ~ ~1 ~ 0.3 0.4 0.3 0.02 2
execute if score @s ch.rage.hang matches 0 run function ch:kit/rage/leap/dive
