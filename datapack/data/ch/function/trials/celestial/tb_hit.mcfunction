# The beam burns the challenger (once): 9 damage and fire.
scoreboard players set @s ch.v1 1
execute as @a[tag=ch.challenger,limit=1] run function ch:trials/celestial/hurt {d:90}
execute as @a[tag=ch.challenger,limit=1] run data merge entity @s {Fire:40s}
