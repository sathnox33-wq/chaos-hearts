# Impaled by the lance.
tag @s add ch.frozen.lh
execute store result score #f_ok ch.tmp run function ch:kit/frozen/hurt
execute if score #f_ok ch.tmp matches 0 run return 0
scoreboard players set #f_ft ch.tmp 40
function ch:kit/frozen/freeze
particle minecraft:block{block_state:"minecraft:blue_ice"} ~ ~1 ~ 0.3 0.5 0.3 0.2 30
