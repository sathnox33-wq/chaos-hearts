# Fire: clear line of sight means a direct hit.
scoreboard players set #los ch.storm.g 0
scoreboard players set #ls ch.storm.g 0
tag @a remove ch.storm.nx
tag @a[tag=ch.challenger,distance=..40,limit=1] add ch.storm.nx
execute positioned ~ ~3.6 ~ facing entity @a[tag=ch.storm.nx,limit=1] eyes run function ch:trials/storm/b/los
execute if score #los ch.storm.g matches 1 positioned ~ ~3.6 ~ run function ch:kit/storm/fn/arc
execute if score #los ch.storm.g matches 1 as @e[tag=ch.boss,distance=..1,limit=1] run function ch:trials/storm/b/caster
execute if score #los ch.storm.g matches 1 as @a[tag=ch.storm.nx,limit=1] at @s run function ch:trials/storm/b/chain_hit
execute if score #los ch.storm.g matches 0 positioned ~ ~3.6 ~ run particle minecraft:electric_spark ~ ~ ~ 1 1 1 0.5 40
execute if score #los ch.storm.g matches 0 run playsound minecraft:block.copper_bulb.turn_off master @a[distance=..60] ~ ~ ~ 1.5 0.8
tag @s remove ch.caster
tag @a remove ch.storm.nx
