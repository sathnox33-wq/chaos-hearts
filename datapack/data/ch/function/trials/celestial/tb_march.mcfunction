# Marches the locked line (half-block steps, 30 blocks), drawing particle $(p), noting if the challenger is on it.
scoreboard players add #ce_n ch.tmp 1
execute unless block ~ ~ ~ #ch:passable run return 0
$particle $(p) ~ ~ ~ 0 0 0 0 1
execute positioned ~ ~-0.9 ~ if entity @a[tag=ch.challenger,distance=..1.3] run scoreboard players set #ce_hitp ch.tmp 1
execute if score #ce_n ch.tmp matches 60.. run return 0
$execute positioned ^ ^ ^0.5 run function ch:trials/celestial/tb_march {p:"$(p)"}
