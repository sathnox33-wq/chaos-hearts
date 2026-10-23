# Static: as the struck enemy, a spark leaps to the nearest other enemy within 6 blocks.
tag @e[tag=ch.storm.nx] remove ch.storm.nx
tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.victim,distance=..6,sort=nearest,limit=1] add ch.storm.nx
execute unless entity @e[tag=ch.storm.nx,limit=1] run return 0
execute positioned ~ ~1 ~ run function ch:kit/storm/fn/arc
scoreboard players set #d ch.storm.g 30
execute as @e[tag=ch.storm.nx,limit=1] at @s run function ch:kit/storm/fn/zap
playsound minecraft:entity.lightning_bolt.impact player @a ~ ~ ~ 0.4 1.8
playsound chaoshearts:storm_chain player @a ~ ~ ~ 0.5 1.6
tag @e[tag=ch.storm.nx] remove ch.storm.nx
