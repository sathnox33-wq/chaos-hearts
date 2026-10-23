# Melee damage dealt since last tick (tenths): 4 Fury plus 1 per point, and Rampage lifesteal.
scoreboard players operation #fa ch.tmp = @s ch.rage.dealt
scoreboard players operation #fa ch.tmp /= #10 ch.g
scoreboard players add #fa ch.tmp 4
execute if score @s ch.rage.ramp matches 1.. run function ch:kit/rage/rampage/steal
function ch:kit/rage/fury/add
scoreboard players set @s ch.rage.dealt 0
