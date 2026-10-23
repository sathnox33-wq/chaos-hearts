# Marks a bomb impact at the ground here.
scoreboard players add #i_rn ch.tmp 1
summon minecraft:marker ~ ~ ~ {Tags:["ch.infernal.gm","ch.noability"]}
scoreboard players set #i_sn ch.tmp 6
execute as @e[type=marker,tag=ch.infernal.gm,limit=1,sort=nearest] at @s run function ch:kit/infernal/gs
execute at @e[type=marker,tag=ch.infernal.gm,limit=1,sort=nearest] align y run function ch:kit/infernal/erupt/rain_mark2 with storage ch:tmp ki
kill @e[type=marker,tag=ch.infernal.gm]
