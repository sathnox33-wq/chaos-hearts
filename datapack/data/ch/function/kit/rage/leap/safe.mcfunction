# Counts down the post-landing fall immunity.
scoreboard players remove @s ch.rage.safe 1
execute if score @s ch.rage.safe matches 0 run attribute @s minecraft:fall_damage_multiplier modifier remove ch:rage_safe
