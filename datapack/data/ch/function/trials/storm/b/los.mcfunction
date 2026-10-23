# Steps from the boss toward the challenger; #los 1 when nothing solid is in the way.
scoreboard players add #ls ch.storm.g 1
execute if score #ls ch.storm.g matches 80.. run return 0
execute unless block ~ ~ ~ #ch:passable run return 0
execute positioned ~ ~-1.2 ~ if entity @a[tag=ch.storm.nx,distance=..1.2] run return run scoreboard players set #los ch.storm.g 1
execute positioned ^ ^ ^0.5 run function ch:trials/storm/b/los
