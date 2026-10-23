# Later: the boss reappears behind the challenger and winds up a blast (telegraphed ring, 14 ticks).
execute as @e[tag=ch.void.boss,distance=..120,limit=1,sort=nearest] at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^ ^ ^-2.6 if block ~ ~ ~ #ch:passable if block ~ ~2 ~ #ch:passable run tp @s ~ ~ ~ facing entity @a[tag=ch.challenger,limit=1] feet
execute as @e[tag=ch.void.boss,distance=..120,limit=1,sort=nearest] at @s run function ch:trials/void/shadow3
