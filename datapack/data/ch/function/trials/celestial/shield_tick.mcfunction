# While shielded: each blow is mostly undone (85%), and counts toward breaking the dome.
execute store result score #ce_h ch.tmp run data get entity @s Health 10
execute if score #ce_h ch.tmp < @s ch.v5 run function ch:trials/celestial/shield_hit
execute if score #ce_h ch.tmp > @s ch.v5 run scoreboard players operation @s ch.v5 = #ce_h ch.tmp
execute if score #t20 ch.g matches 0 run particle minecraft:end_rod ~ ~1.5 ~ 2 2 2 0 10
