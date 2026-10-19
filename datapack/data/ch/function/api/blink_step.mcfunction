scoreboard players remove #rs ch.tmp 1
execute positioned ^ ^ ^0.5 unless block ~ ~ ~ #ch:passable run return run tp @s ~ ~ ~
execute positioned ^ ^ ^0.5 unless block ~ ~1 ~ #ch:passable run return run tp @s ~ ~ ~
execute if score #rs ch.tmp matches ..0 run return run tp @s ~ ~ ~
particle minecraft:end_rod ~ ~1 ~ 0.05 0.3 0.05 0 1
execute positioned ^ ^ ^0.5 run function ch:api/blink_step
