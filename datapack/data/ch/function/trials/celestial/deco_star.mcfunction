# A star orbiting Astrael (offset in its own frame, turned by its yaw).
data merge entity @s {Tags:["ch.tmob","ch.noability","ch.celestial.bdeco","ch.celestial.bstar"],teleport_duration:1,billboard:"center",brightness:{sky:15,block:15},view_range:4.0f,item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/star","minecraft:custom_model_data":{colors:[16773808]}}},transformation:{left_rotation:{axis:[1f,0f,0f],angle:1.5708f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.9f,0.9f,0.9f]}}
tp @s ~ ~1.2 ~ ~ 0
