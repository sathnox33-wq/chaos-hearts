# Storm stopped being active: removes its modifiers and ends Tempest.
attribute @s minecraft:movement_speed modifier remove ch:storm_rain
execute if score @s ch.storm.temp matches 1.. run function ch:kit/storm/tempest/end
scoreboard players set @s ch.storm.temp 0
scoreboard players set @s ch.storm.ww 0
scoreboard players set @s ch.meter 0
