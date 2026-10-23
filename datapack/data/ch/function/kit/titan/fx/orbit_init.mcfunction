# An orbiting shard owned by the Titan (#ti_pid); its life is refreshed while the skin lasts.
data merge entity @s {Tags:["ch.fx","ch.noability","ch.titan.orbit"],teleport_duration:2,view_range:2.0f,brightness:{sky:15,block:12},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/shard","minecraft:custom_model_data":{colors:[13214812]}}},transformation:{left_rotation:[0.38f,0f,0f,0.92f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.45f,0.45f,0.45f]}}
tp @s ~ ~1 ~ ~ 0
scoreboard players operation @s ch.owner = #ti_pid ch.tmp
scoreboard players set @s ch.life 8
scoreboard players set #fx ch.g 1
