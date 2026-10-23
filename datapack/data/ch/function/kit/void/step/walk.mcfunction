# Walks the fold forward in half blocks, stopping before walls; Null Dash marks enemies on the way.
scoreboard players remove #vrs ch.tmp 1
execute unless block ^ ^ ^0.5 #ch:passable run return run summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
execute unless block ^ ^1 ^0.5 #ch:passable run return run summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
scoreboard players add #vsteps ch.tmp 1
particle minecraft:dust{color:[0.541,0.235,1.0],scale:1.3} ^ ^0.9 ^0.5 0.08 0.4 0.08 0 3
particle minecraft:reverse_portal ^ ^1 ^0.5 0.1 0.3 0.1 0.01 2
particle minecraft:dust{color:[0.039,0.0,0.078],scale:1.8} ^ ^1 ^0.5 0.05 0.3 0.05 0 1
execute if score #vnd ch.tmp matches 1 positioned ^ ^1 ^0.5 run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.6] add ch.void.path
execute if score #vrs ch.tmp matches ..0 positioned ^ ^ ^0.5 run return run summon marker ~ ~ ~ {Tags:["ch.void.dest","ch.noability"]}
execute positioned ^ ^ ^0.5 run function ch:kit/void/step/walk
