# The caster rides the updraft: a burst of wind under the feet, then a slow fall (Updraft: higher and longer).
execute positioned ~ ~0.2 ~ summon minecraft:wind_charge run data merge entity @s {Motion:[0.0,-1.0,0.0]}
execute if score @s ch.b2 matches 2.. positioned ~ ~0.2 ~ summon minecraft:wind_charge run data merge entity @s {Motion:[0.0,-1.0,0.0]}
execute unless score @s ch.b2 matches 2.. run effect give @s minecraft:slow_falling 3 0 true
execute if score @s ch.b2 matches 2.. run effect give @s minecraft:slow_falling 6 0 true
particle minecraft:cloud ~ ~0.2 ~ 0.6 0.1 0.6 0.15 30
