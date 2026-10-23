# Forked Bolt: a second bolt for the nearest other enemy within 8 blocks.
tag @e[tag=ch.storm.nx] remove ch.storm.nx
tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=2.5..8,sort=nearest,limit=1] add ch.storm.nx
execute unless entity @e[tag=ch.storm.nx,limit=1] run return 0
execute positioned ~ ~4 ~ run function ch:kit/storm/fn/arc
scoreboard players operation #v1 ch.storm.g = @s ch.v1
scoreboard players operation #v1 ch.storm.g *= #c6 ch.storm.g
scoreboard players operation #v1 ch.storm.g /= #c10 ch.storm.g
scoreboard players set #v2 ch.storm.g 0
scoreboard players set #v3 ch.storm.g 1
scoreboard players set #v4 ch.storm.g 0
execute at @e[tag=ch.storm.nx,limit=1] run function ch:kit/storm/ls/mark_fast
tag @e[tag=ch.storm.nx] remove ch.storm.nx
