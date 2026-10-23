# The Colossus shrinks back: modifiers end, health is clamped by the game, dust falls away.
function ch:kit/titan/col/strip
scoreboard players set @s ch.titan.grow 0
scoreboard players set @s ch.titan.col 0
particle minecraft:cloud ~ ~1 ~ 0.6 0.8 0.6 0.05 30
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.6 0.8 0.6 0.1 40
playsound minecraft:entity.iron_golem.death player @a ~ ~ ~ 0.6 1.2
