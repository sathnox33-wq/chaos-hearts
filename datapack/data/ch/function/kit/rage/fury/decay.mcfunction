# Four seconds without fighting or bleeding: Fury drains 2 every 5 ticks.
scoreboard players operation #m ch.tmp = @s ch.rage.calm
scoreboard players operation #m ch.tmp %= #5 ch.g
execute unless score #m ch.tmp matches 0 run return 0
scoreboard players remove @s ch.rage.fury 2
execute if score @s ch.rage.fury matches ..-1 run scoreboard players set @s ch.rage.fury 0
function ch:kit/rage/fury/meter
