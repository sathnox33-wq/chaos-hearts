# Checks the tether's line of sight without drawing.
scoreboard players remove #ln ch.tmp 1
execute unless block ~ ~ ~ #ch:passable run return run scoreboard players set #los ch.tmp 0
execute if entity @a[tag=ch.challenger,distance=..1.2,limit=1] run return 0
execute if score #ln ch.tmp matches 1.. positioned ^ ^ ^0.5 run function ch:trials/blood/tether_check
