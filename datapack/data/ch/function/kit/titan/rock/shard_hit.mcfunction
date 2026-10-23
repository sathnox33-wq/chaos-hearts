# A shard strikes (targets tagged ch.target): 3.5 damage (4.5 with Heavy Rock) and a small shove.
scoreboard players set #ti_d ch.tmp 35
execute if entity @a[tag=ch.caster,scores={ch.b3=1..},limit=1] run scoreboard players set #ti_d ch.tmp 45
execute as @e[tag=ch.target] run function ch:kit/titan/rock/shard_dmg
