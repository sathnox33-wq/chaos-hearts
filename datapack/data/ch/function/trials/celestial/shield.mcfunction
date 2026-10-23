# Sanctuary (phase 2+): a dome of light; it shrugs off most damage until struck 7 times.
scoreboard players set @s ch.celestial.tb1 360
scoreboard players set @s ch.v4 7
execute store result score @s ch.v5 run data get entity @s Health 10
function ch:trials/celestial/callout {m:"Astrael raises a sanctuary! Strike it 7 times to break it!"}
playsound minecraft:block.beacon.power_select master @a ~ ~ ~ 2 1.4
playsound chaoshearts:celestial_sanctuary master @a ~ ~ ~ 2 1
execute positioned ~ ~1 ~ summon item_display run data merge entity @s {Tags:["ch.tmob","ch.noability","ch.celestial.bdeco","ch.celestial.bdome","ch.celestial.spin"],teleport_duration:1,brightness:{sky:15,block:15},view_range:4.0f,interpolation_duration:10,item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/dome","minecraft:custom_model_data":{colors:[12576511]}}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-1.2f,0f],scale:[5.5f,5.5f,5.5f]}}
