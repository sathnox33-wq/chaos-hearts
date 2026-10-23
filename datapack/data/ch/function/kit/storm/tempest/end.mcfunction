# Tempest ends: flight goes, a last roll of thunder.
scoreboard players set @s ch.storm.temp 0
scoreboard players set @s ch.meter 0
effect clear @s minecraft:levitation
effect give @s minecraft:slow_falling 4 0 true
particle minecraft:cloud ~ ~5 ~ 3 0.5 3 0.05 40
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 0.8 0.5
