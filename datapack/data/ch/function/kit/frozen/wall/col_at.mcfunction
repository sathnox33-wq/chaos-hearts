# Snaps a wall column to the ground here and raises it.
summon minecraft:marker ~ ~ ~ {Tags:["ch.frozen.gm","ch.noability"]}
scoreboard players set #f_sn ch.tmp 4
execute as @e[type=marker,tag=ch.frozen.gm,limit=1,sort=nearest] at @s run function ch:kit/frozen/gs
execute at @e[type=marker,tag=ch.frozen.gm,limit=1,sort=nearest] align xyz positioned ~0.5 ~ ~0.5 run function ch:kit/frozen/wall/col
kill @e[type=marker,tag=ch.frozen.gm]
