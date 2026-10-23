# The ice breaks away.
execute if block ~ ~ ~ minecraft:packed_ice run setblock ~ ~ ~ minecraft:air
particle minecraft:block{block_state:"minecraft:packed_ice"} ~ ~0.5 ~ 0.3 0.3 0.3 0.1 10
playsound minecraft:block.glass.break block @a ~ ~ ~ 0.4 1.2
kill @s
