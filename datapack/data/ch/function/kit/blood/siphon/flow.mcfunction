# Traces the tether toward the caster: blood droplets along it; a solid block cuts it.
scoreboard players remove #ln ch.tmp 1
execute unless block ~ ~ ~ #ch:passable run return run scoreboard players set #los ch.tmp 0
execute if entity @a[tag=ch.caster,distance=..0.9,limit=1] run return 0
scoreboard players operation #k ch.tmp = #ln ch.tmp
scoreboard players operation #k ch.tmp += #now ch.g
scoreboard players operation #k ch.tmp %= #3 ch.blood.g
execute if score #k ch.tmp matches 0 run particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.1} ~ ~ ~ 0.02 0.02 0.02 0 1
execute unless score #k ch.tmp matches 0 run particle minecraft:dust{color:[0.62,0.04,0.12],scale:0.8} ~ ~ ~ 0.02 0.02 0.02 0 1
execute if score #ln ch.tmp matches 1.. positioned ^ ^ ^0.5 run function ch:kit/blood/siphon/flow
