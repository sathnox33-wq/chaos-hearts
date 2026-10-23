# Waits for its moment, then freezes into place (only into air).
scoreboard players remove @s ch.v1 1
execute if score @s ch.v1 matches 1.. run return 0
execute unless block ~ ~ ~ #minecraft:air run return run kill @s
setblock ~ ~ ~ minecraft:packed_ice
particle minecraft:block{block_state:"minecraft:packed_ice"} ~ ~0.5 ~ 0.3 0.3 0.3 0.05 6
particle minecraft:snowflake ~ ~0.5 ~ 0.4 0.4 0.4 0.02 4
playsound minecraft:block.glass.place block @a ~ ~ ~ 0.5 0.8
