# Stone shard: emissive tinted model, slides 1.9 blocks forward over 4 ticks.
data merge entity @s {Tags:["ch.fx","ch.noability","ch.titan.slide"],teleport_duration:4,view_range:2.0f,brightness:{sky:15,block:12},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/shard","minecraft:custom_model_data":{colors:[8025194]}}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.6f,0.6f,0.6f]}}
tp @s ~ ~ ~ ~ ~
scoreboard players set @s ch.v6 19
scoreboard players set @s ch.life 9
scoreboard players operation @s ch.t = #now ch.g
scoreboard players set #fx ch.g 1
