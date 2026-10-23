# Rampage effects, refreshed every second.
effect give @s minecraft:speed 2 1 true
effect give @s minecraft:strength 2 1 true
execute unless score @s ch.rage.rv matches 2 run effect give @s minecraft:resistance 2 0 true
