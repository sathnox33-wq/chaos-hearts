# Adds #fa ch.tmp Fury (capped at 100, or 150 awakened) and fires the full-Fury events.
scoreboard players set @s ch.rage.calm 0
scoreboard players operation #fb ch.tmp = @s ch.rage.fury
scoreboard players operation @s ch.rage.fury += #fa ch.tmp
scoreboard players set #cap ch.tmp 100
execute if score @s ch.awake matches 1 run scoreboard players set #cap ch.tmp 150
execute if score @s ch.rage.fury > #cap ch.tmp run scoreboard players operation @s ch.rage.fury = #cap ch.tmp
execute if score @s ch.rage.fury matches ..-1 run scoreboard players set @s ch.rage.fury 0
execute if score #fb ch.tmp matches ..99 if score @s ch.rage.fury matches 100.. run function ch:kit/rage/fury/full
function ch:kit/rage/fury/meter
