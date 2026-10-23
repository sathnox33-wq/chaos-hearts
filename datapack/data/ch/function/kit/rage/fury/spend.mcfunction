# Spends #fs ch.tmp Fury.
scoreboard players operation @s ch.rage.fury -= #fs ch.tmp
execute if score @s ch.rage.fury matches ..-1 run scoreboard players set @s ch.rage.fury 0
function ch:kit/rage/fury/meter
