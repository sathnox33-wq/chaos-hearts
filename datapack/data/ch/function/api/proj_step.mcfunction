scoreboard players remove #steps ch.tmp 1
tp @s ^ ^ ^0.25
execute at @s unless block ~ ~ ~ #ch:passable run return run function ch:api/proj_end with storage ch:tmp p
$execute at @s positioned ~-0.5 ~-0.5 ~-0.5 if entity @e[dx=0,dy=0,dz=0,type=!#ch:ignore,tag=!$(ignore),tag=!ch.noability,tag=!ch.ph$(id)] at @s run return run function ch:api/proj_hit with storage ch:tmp p
execute if score #steps ch.tmp matches 1.. at @s run function ch:api/proj_step with storage ch:tmp p
