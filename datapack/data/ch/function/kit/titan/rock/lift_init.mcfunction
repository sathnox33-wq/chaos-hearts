# The lifted boulder rises 3.4 blocks over 7 ticks and belongs to the Titan.
execute at @s run tp @s ~ ~ ~ ~ -90
scoreboard players set @s ch.v6 34
scoreboard players set @s ch.life 14
scoreboard players operation @s ch.t = #now ch.g
scoreboard players operation @s ch.owner = #ti_pid ch.tmp
scoreboard players set #fx ch.g 1
