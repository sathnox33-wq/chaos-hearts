# The Avalanche window: if it closes unused, the cooldown resumes where it was.
scoreboard players remove @s ch.rage.ava 1
particle minecraft:flame ~ ~0.1 ~ 0.3 0 0.3 0.01 1
execute if score @s ch.rage.ava matches 0 if score @s ch.cd1 matches 0 run function ch:kit/rage/leap/ava_expire
