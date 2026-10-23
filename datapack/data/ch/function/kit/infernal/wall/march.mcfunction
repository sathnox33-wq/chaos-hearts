# Inferno Tide: the segment marches forward, shoving enemies before it.
scoreboard players remove @s ch.v2 1
execute positioned ^ ^ ^0.35 unless block ~ ~0.5 ~ #ch:passable run return run scoreboard players set @s ch.v2 0
tp @s ^ ^ ^0.35
scoreboard players set #i_sn ch.tmp 2
execute at @s run function ch:kit/infernal/gs
scoreboard players operation #i_p ch.tmp = @s ch.v2
scoreboard players operation #i_p ch.tmp %= #4 ch.g
execute if score #i_p ch.tmp matches 0 positioned ^ ^ ^-1.2 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.4] run function ch:api/push {s:0.55,y:0.25}
execute if score #i_p ch.tmp matches 1 run function ch:kit/infernal/wall/flicker
particle minecraft:flame ^ ^0.4 ^0.6 0.2 0.3 0.2 0.04 3
