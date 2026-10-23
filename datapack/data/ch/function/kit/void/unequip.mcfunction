# Void stopped being active: close the rift and drop the timers.
scoreboard players operation #vme ch.tmp = @s ch.pid
execute as @e[type=marker,tag=ch.void.rift] if score @s ch.owner = #vme ch.tmp run kill @s
scoreboard players set @s ch.void.st 0
