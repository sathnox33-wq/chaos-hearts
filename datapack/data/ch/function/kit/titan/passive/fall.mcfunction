# Counts down the fall-damage immunity a slam landing leaves behind.
scoreboard players remove @s ch.titan.fall 1
execute if score @s ch.titan.fall matches 0 run attribute @s minecraft:fall_damage_multiplier modifier remove ch:titan_fall
