# The Titan becomes a Colossus: health, reach, strength, step height; it grows over 10 ticks.
scoreboard players set @s ch.titan.col 240
execute if score @s ch.b3 matches 3.. run scoreboard players set @s ch.titan.col 312
execute if score @s ch.titan.colm matches 2 run scoreboard players set @s ch.titan.col 160
execute if score @s ch.titan.colm matches 2 if score @s ch.b3 matches 3.. run scoreboard players set @s ch.titan.col 208
scoreboard players set @s ch.titan.kills 0
scoreboard players set @s ch.titan.grow 10
scoreboard players set @s ch.titan.gst 0
function ch:kit/titan/col/strip
execute unless score @s ch.titan.colm matches 2 run attribute @s minecraft:max_health modifier add ch:titan_colossus 10 add_value
execute if score @s ch.titan.colm matches 2 run attribute @s minecraft:max_health modifier add ch:titan_colossus 20 add_value
execute unless score @s ch.b3 matches 4.. run attribute @s minecraft:entity_interaction_range modifier add ch:titan_colossus 1.5 add_value
execute if score @s ch.b3 matches 4.. run attribute @s minecraft:entity_interaction_range modifier add ch:titan_colossus 3 add_value
execute unless score @s ch.b3 matches 4.. run attribute @s minecraft:block_interaction_range modifier add ch:titan_colossus 1.5 add_value
execute if score @s ch.b3 matches 4.. run attribute @s minecraft:block_interaction_range modifier add ch:titan_colossus 3 add_value
attribute @s minecraft:attack_damage modifier add ch:titan_colossus 3 add_value
attribute @s minecraft:step_height modifier add ch:titan_colossus 1 add_value
attribute @s minecraft:knockback_resistance modifier add ch:titan_colossus 0.5 add_value
execute if score @s ch.titan.colm matches 2 run attribute @s minecraft:movement_speed modifier add ch:titan_colossus -0.85 add_multiplied_total
execute if score @s ch.titan.colm matches 2 run attribute @s minecraft:jump_strength modifier add ch:titan_colossus -1 add_multiplied_total
execute if score @s ch.titan.colm matches 2 run effect give @s minecraft:resistance 11 0 true
effect give @s minecraft:instant_health 1 1 true
function ch:kit/titan/col/rise_fx
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5] run function ch:api/push {s:1.0,y:0.4}
