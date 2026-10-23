# The fault line ends in a last burst of rock; on a Cataclysm a crown of jagged spikes bursts out and hurts.
particle minecraft:explosion ~ ~0.5 ~ 0.3 0.2 0.3 0 2
particle minecraft:campfire_cosy_smoke ~ ~0.5 ~ 0.4 0.2 0.4 0.02 4
playsound minecraft:block.deepslate.break player @a ~ ~ ~ 1 0.5
execute if score @s ch.v5 matches 1 run function ch:kit/titan/slam/spikes
kill @s
