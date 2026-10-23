# Draws the tether toward the challenger; a solid block cuts it.
scoreboard players remove #ln ch.tmp 1
execute unless block ~ ~ ~ #ch:passable run return run scoreboard players set #los ch.tmp 0
execute if entity @a[tag=ch.challenger,distance=..1.2,limit=1] run return 0
particle minecraft:dust{color:[0.62,0.04,0.12],scale:1.2} ~ ~ ~ 0.02 0.02 0.02 0 1
execute if score #ln ch.tmp matches 1.. positioned ^ ^ ^0.5 run function ch:trials/blood/tether_flow
