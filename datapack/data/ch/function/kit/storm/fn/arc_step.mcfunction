# One jagged step of an arc.
scoreboard players add #as ch.storm.g 1
scoreboard players operation #k ch.storm.g = #as ch.storm.g
scoreboard players operation #k ch.storm.g %= #c4 ch.storm.g
execute if score #k ch.storm.g matches 0 run particle minecraft:electric_spark ^0.18 ^0.1 ^ 0 0 0 0 1
execute if score #k ch.storm.g matches 1 run particle minecraft:dust{color:[0.91,0.96,1.0],scale:1.0} ^ ^-0.15 ^ 0 0 0 0 1
execute if score #k ch.storm.g matches 2 run particle minecraft:electric_spark ^-0.18 ^0.05 ^ 0 0 0 0 1
execute if score #k ch.storm.g matches 3 run particle minecraft:dust{color:[0.31,0.66,1.0],scale:1.3} ^ ^0.15 ^ 0 0 0 0 1
particle minecraft:end_rod ~ ~ ~ 0 0 0 0 1
execute if score #as ch.storm.g matches 40.. run return 0
execute positioned ~ ~-1.2 ~ if entity @e[tag=ch.storm.nx,distance=..1.3] run return 0
execute positioned ^ ^ ^0.4 run function ch:kit/storm/fn/arc_step
