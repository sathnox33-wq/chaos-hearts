# A falling star: billboarded star model, 12 ticks of fall carrying the strike's numbers.
data merge entity @s {Tags:["ch.noability","ch.celestial.star"],billboard:"center",teleport_duration:1,brightness:{sky:15,block:15},view_range:4.0f,item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/star","minecraft:custom_model_data":{colors:[16773808]}}},transformation:{left_rotation:{axis:[1f,0f,0f],angle:1.5708f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.6f,1.6f,1.6f]}}
tp @s ~ ~ ~ ~ ~
scoreboard players set @s ch.life 12
scoreboard players operation @s ch.v1 = #ce_d ch.tmp
scoreboard players operation @s ch.v2 = #ce_r ch.tmp
scoreboard players operation @s ch.v3 = #ce_sm ch.tmp
scoreboard players operation @s ch.v4 = #ce_co ch.tmp
scoreboard players operation @s ch.v5 = #ce_as ch.tmp
scoreboard players operation @s ch.v6 = #ce_nv ch.tmp
scoreboard players operation @s ch.owner = #ce_pid ch.tmp
execute if score #ce_sm ch.tmp matches 1 run data merge entity @s {transformation:{scale:[0.9f,0.9f,0.9f]}}
execute if score #ce_co ch.tmp matches 1 run data merge entity @s {transformation:{scale:[2.6f,2.6f,2.6f]},item:{components:{"minecraft:custom_model_data":{colors:[16763210]}}}}
