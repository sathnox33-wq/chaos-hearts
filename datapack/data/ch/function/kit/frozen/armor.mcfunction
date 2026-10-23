# As the melee attacker of a Frost Armor player.
function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:1}
particle minecraft:snowflake ~ ~1.4 ~ 0.3 0.4 0.3 0.05 12
particle minecraft:block{block_state:"minecraft:ice"} ~ ~1 ~ 0.3 0.4 0.3 0.05 6
playsound minecraft:block.glass.hit player @a ~ ~ ~ 0.6 1.6
