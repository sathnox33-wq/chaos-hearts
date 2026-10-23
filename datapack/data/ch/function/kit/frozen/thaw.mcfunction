# The ice cracks away.
tag @s remove ch.frozen.solid
particle minecraft:block{block_state:"minecraft:ice"} ~ ~1 ~ 0.3 0.5 0.3 0.05 12
playsound minecraft:block.glass.hit player @a ~ ~ ~ 0.6 1.2
