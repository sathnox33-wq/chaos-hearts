# Starts (or restarts) Rampage for $(t) ticks, +30% with Unstoppable.
$scoreboard players set @s ch.rage.ramp $(t)
execute if score @s ch.b2 matches 3.. run scoreboard players operation @s ch.rage.ramp *= #13 ch.rage.g
execute if score @s ch.b2 matches 3.. run scoreboard players operation @s ch.rage.ramp /= #10 ch.g
scoreboard players set @s ch.rage.ls 0
function ch:kit/rage/rampage/buffs
