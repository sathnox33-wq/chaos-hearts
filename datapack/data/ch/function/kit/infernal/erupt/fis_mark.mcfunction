# Snaps a fissure point to the ground and marks it.
summon minecraft:marker ~ ~ ~ {Tags:["ch.infernal.gm","ch.noability"]}
scoreboard players set #i_sn ch.tmp 4
execute as @e[type=marker,tag=ch.infernal.gm,limit=1,sort=nearest] at @s run function ch:kit/infernal/gs
execute at @e[type=marker,tag=ch.infernal.gm,limit=1,sort=nearest] align y run function ch:kit/infernal/erupt/fis_mark2 with storage ch:tmp ki
kill @e[type=marker,tag=ch.infernal.gm]
