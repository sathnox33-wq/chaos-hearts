# The rise ends: gravity lets go and the Celestial hangs in the air.
attribute @s minecraft:gravity modifier add ch:celestial_hover -1 add_multiplied_total
effect clear @s minecraft:levitation
particle minecraft:end_rod ~ ~1 ~ 0.5 0.5 0.5 0.1 30
playsound minecraft:block.amethyst_block.resonate player @a ~ ~ ~ 1 1.8
