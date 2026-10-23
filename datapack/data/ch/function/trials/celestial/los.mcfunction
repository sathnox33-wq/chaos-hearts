# Line of sight from the Supernova to the challenger's eyes (half-block steps, up to 60 blocks).
scoreboard players add #ce_n ch.tmp 1
execute positioned ~ ~-1.62 ~ if entity @a[tag=ch.challenger,distance=..1.0] run return run scoreboard players set #ce_los ch.tmp 1
execute unless block ~ ~ ~ #ch:passable run return 0
execute if score #ce_n ch.tmp matches 120.. run return 0
execute positioned ^ ^ ^0.5 run function ch:trials/celestial/los
