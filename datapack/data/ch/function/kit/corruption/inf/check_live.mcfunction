# As a tagged host: drops a stale host tag (for example on a player who died and respawned) if no infection holds it.
scoreboard players operation #chk ch.tmp = @s ch.corruption.hid
scoreboard players set #clive ch.tmp 0
execute as @e[type=marker,tag=ch.corruption.inf,distance=..40] if score @s ch.eid = #chk ch.tmp run scoreboard players set #clive ch.tmp 1
execute if score #clive ch.tmp matches 0 run tag @s remove ch.corruption.host
