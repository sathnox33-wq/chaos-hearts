# One half-block of a dash, as the dashing player: tag what is near, draw the streak, stop before walls.
scoreboard players remove #rs ch.speed.g 1
scoreboard players add #steps ch.speed.g 1
execute positioned ~ ~0.9 ~ run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.9] add ch.speed.cut
particle minecraft:dust_color_transition{from_color:[0.96,0.88,0.26],to_color:[0.16,0.83,0.95],scale:1.3} ~ ~1 ~ 0.15 0.35 0.15 0 3
particle minecraft:end_rod ~ ~0.9 ~ 0.05 0.05 0.05 0.01 1
execute if score @s ch.awake matches 1 run particle minecraft:electric_spark ~ ~1.2 ~ 0.1 0.1 0.1 0.05 2
scoreboard players operation #m ch.speed.g = #steps ch.speed.g
scoreboard players operation #m ch.speed.g %= #c4 ch.speed.g
execute if score #m ch.speed.g matches 0 run function ch:kit/speed/dash/mark
execute if score #rs ch.speed.g matches ..0 run return run tp @s ~ ~ ~
execute positioned ^ ^ ^0.5 unless block ~ ~ ~ #ch:passable run return run tp @s ~ ~ ~
execute positioned ^ ^ ^0.5 unless block ~ ~1 ~ #ch:passable run return run tp @s ~ ~ ~
execute positioned ^ ^ ^0.5 run function ch:kit/speed/dash/step
