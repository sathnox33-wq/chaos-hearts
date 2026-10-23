# Blizzard tick (as the boss): snow storms around the challenger, who builds Cold while standing still.
scoreboard players remove @s ch.frozen.zero 1
execute as @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] at @s run function ch:trials/frozen/cold
