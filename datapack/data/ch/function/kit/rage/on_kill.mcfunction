# Rage kills: +15 Fury, Rampage extends by 3 s, and the Last Stand feat.
scoreboard players set #fa ch.tmp 15
function ch:kit/rage/fury/add
execute if score @s ch.rage.ramp matches 1.. run function ch:kit/rage/rampage/extend
