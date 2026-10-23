# Feather $(n) of the wings of light.
$scoreboard players set @s ch.v1 $(n)
data merge entity @s {Tags:["ch.fx","ch.noability","ch.celestial.wing","ch.celestial.follow"],teleport_duration:1,brightness:{sky:15,block:15},view_range:2.0f,item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/feather","minecraft:custom_model_data":{colors:[16773808]}}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.1f,1.1f,1.1f]}}
scoreboard players operation @s ch.owner = #ce_pid ch.tmp
scoreboard players set @s ch.life 6
scoreboard players set #fx ch.g 1
