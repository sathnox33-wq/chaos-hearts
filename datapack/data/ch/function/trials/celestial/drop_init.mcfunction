# A falling star display for the trial.
data merge entity @s {Tags:["ch.tmob","ch.noability","ch.celestial.tdrop","ch.fx"],billboard:"center",teleport_duration:8,brightness:{sky:15,block:15},view_range:4.0f,item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/star","minecraft:custom_model_data":{colors:[16773808]}}},transformation:{left_rotation:{axis:[1f,0f,0f],angle:1.5708f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.8f,1.8f,1.8f]}}
scoreboard players operation @s ch.t = #now ch.g
scoreboard players set @s ch.life 11
scoreboard players set #fx ch.g 1
