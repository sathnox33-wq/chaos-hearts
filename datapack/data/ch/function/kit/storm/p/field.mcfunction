# Static Field: whoever just hit you during Tempest is struck back.
tag @s add ch.caster
tag @e[tag=ch.storm.nx] remove ch.storm.nx
execute on attacker if entity @s[distance=..16] run tag @s add ch.storm.nx
execute unless entity @e[tag=ch.storm.nx,limit=1] run return run tag @s remove ch.caster
execute positioned ~ ~1 ~ run function ch:kit/storm/fn/arc
scoreboard players set #d ch.storm.g 30
execute as @e[tag=ch.storm.nx,limit=1] at @s run function ch:kit/storm/fn/zap
playsound minecraft:entity.lightning_bolt.impact player @a ~ ~ ~ 0.6 1.6
tag @e[tag=ch.storm.nx] remove ch.storm.nx
tag @s remove ch.caster
