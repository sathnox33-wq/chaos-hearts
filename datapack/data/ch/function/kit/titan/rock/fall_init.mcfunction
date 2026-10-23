# The falling boulder drops 23 blocks and fades just after impact.
execute at @s run tp @s ~ ~ ~ 0 90
scoreboard players set @s ch.v6 230
scoreboard players set @s ch.life 14
scoreboard players operation @s ch.t = #now ch.g
scoreboard players set #fx ch.g 1
