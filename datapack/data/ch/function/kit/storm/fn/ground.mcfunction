# Drops the marker ch.storm.gm from here down onto the first solid floor (at most 12 blocks).
scoreboard players add #gn ch.storm.g 1
execute if score #gn ch.storm.g matches 12.. run return run tp @e[type=marker,tag=ch.storm.gm,limit=1] ~ ~ ~
execute unless block ~ ~-1 ~ #ch:passable run return run tp @e[type=marker,tag=ch.storm.gm,limit=1] ~ ~ ~
execute positioned ~ ~-1 ~ run function ch:kit/storm/fn/ground
