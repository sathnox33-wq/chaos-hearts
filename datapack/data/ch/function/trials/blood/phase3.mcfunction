# Phase 3: the Blood Moon rises over the sanctum, two Bloodthralls claw out of the pools, she grows and quickens.
scoreboard players set @s ch.v4 30
attribute @s minecraft:scale base set 1.85
attribute @s minecraft:movement_speed base set 0.48
execute as @e[type=marker,tag=ch.session,distance=..80,limit=1] at @s positioned ~ ~18 ~ run summon item_display ~ ~ ~ {Tags:["ch.tmob","ch.noability","ch.blood.tmoon"],brightness:{sky:15,block:15},item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[9f,9f,9f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/orb","minecraft:custom_model_data":{colors:[10357535]}}}}
execute as @e[type=marker,tag=ch.session,distance=..80,limit=1] at @s positioned ~ ~18 ~ run summon item_display ~ ~ ~ {Tags:["ch.tmob","ch.noability","ch.blood.tmoon"],brightness:{sky:15,block:15},item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[16f,1f,16f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/ring_soft","minecraft:custom_model_data":{colors:[16723263]}}}}
summon minecraft:zombie ~3 ~ ~ {Tags:["ch.blood.new","ch.blood.mob"],PersistenceRequired:1b,IsBaby:0b,CustomName:{text:"Bloodthrall",color:"#9E0B1F"},equipment:{mainhand:{id:"minecraft:iron_sword",count:1}},drop_chances:{mainhand:0.0f},attributes:[{id:"minecraft:max_health",base:28.0},{id:"minecraft:attack_damage",base:6.0},{id:"minecraft:follow_range",base:48.0}],Health:28.0f}
summon minecraft:zombie ~-3 ~ ~ {Tags:["ch.blood.new","ch.blood.mob"],PersistenceRequired:1b,IsBaby:0b,CustomName:{text:"Bloodthrall",color:"#9E0B1F"},equipment:{mainhand:{id:"minecraft:iron_sword",count:1}},drop_chances:{mainhand:0.0f},attributes:[{id:"minecraft:max_health",base:28.0},{id:"minecraft:attack_damage",base:6.0},{id:"minecraft:follow_range",base:48.0}],Health:28.0f}
execute as @e[tag=ch.blood.new,distance=..20] run function ch:api/trial/adopt
execute as @e[tag=ch.blood.new,distance=..20] at @s run function ch:trials/blood/spawn_fx
tag @e[tag=ch.blood.new] remove ch.blood.new
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
function ch:api/fx/wave {color:16723263,r:18.0,t:14}
function ch:api/fx/shake {s:3,t:20,r:60}
playsound chaoshearts:blood_moon master @a[distance=..90] ~ ~ ~ 2.5 0.8
playsound minecraft:entity.wither.spawn master @a[distance=..90] ~ ~ ~ 1 1.4
function ch:trials/blood/say {m:"The Blood Moon rises. She will not stop drinking now."}
execute as @a[tag=ch.challenger,distance=..90] run function ch:api/fx/screen {o:"blood",color:"#5A0010",in:4,stay:14,out:24}
