# Rage became the active heart: clears stale damage counters and shows the Fury meter.
scoreboard players set @s ch.rage.dmg 0
scoreboard players set @s ch.rage.dealt 0
scoreboard players add @s ch.rage.fury 0
scoreboard players set @s ch.rage.s50 0
scoreboard players set @s ch.rage.s100 0
function ch:kit/rage/fury/meter
playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 1 0.8
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.4} ~ ~1 ~ 0.4 0.6 0.4 0 25
