# Stormborn: +20% movement speed in the rain (Tailwind: in any weather).
scoreboard players set #rain ch.storm.g 0
execute if predicate {condition:"minecraft:weather_check",raining:true} if predicate {condition:"minecraft:location_check",predicate:{can_see_sky:true}} run scoreboard players set #rain ch.storm.g 1
execute if score @s ch.b2 matches 4.. run scoreboard players set #rain ch.storm.g 1
execute if score #rain ch.storm.g matches 1 run attribute @s minecraft:movement_speed modifier add ch:storm_rain 0.2 add_multiplied_total
execute if score #rain ch.storm.g matches 0 run attribute @s minecraft:movement_speed modifier remove ch:storm_rain
