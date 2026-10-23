# Wave 3: Plague Husks shamble in with archers and a fresh brood.
execute positioned ~11.8 ~1 ~2.4 run function ch:trials/corruption/spawn_fx
summon cave_spider ~11.8 ~1 ~2.4 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-7.9 ~1 ~9.0 run function ch:trials/corruption/spawn_fx
summon cave_spider ~-7.9 ~1 ~9.0 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-3.8 ~1 ~-11.4 run function ch:trials/corruption/spawn_fx
summon cave_spider ~-3.8 ~1 ~-11.4 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~4.8 ~1 ~17.3 run function ch:trials/corruption/spawn_fx
summon bogged ~4.8 ~1 ~17.3 {Tags:["ch.corruption.tn"],CustomName:{text:"Rotting Archer",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:24.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:follow_range",base:48.0}],Health:24f,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:moss_carpet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f}}
execute positioned ~-4.8 ~1 ~-17.3 run function ch:trials/corruption/spawn_fx
summon bogged ~-4.8 ~1 ~-17.3 {Tags:["ch.corruption.tn"],CustomName:{text:"Rotting Archer",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:24.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:follow_range",base:48.0}],Health:24f,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:moss_carpet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f}}
execute positioned ~11.5 ~1 ~9.7 run function ch:trials/corruption/spawn_fx
summon husk ~11.5 ~1 ~9.7 {Tags:["ch.corruption.tn"],CustomName:{text:"Plague Husk",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:34.0},{id:"minecraft:attack_damage",base:6.0},{id:"minecraft:movement_speed",base:0.26},{id:"minecraft:follow_range",base:48.0}],Health:34f,equipment:{head:{id:"minecraft:moss_carpet",count:1},mainhand:{id:"minecraft:stone_hoe",count:1}},drop_chances:{mainhand:0.0f,head:0.0f}}
execute positioned ~-14.1 ~1 ~5.1 run function ch:trials/corruption/spawn_fx
summon husk ~-14.1 ~1 ~5.1 {Tags:["ch.corruption.tn"],CustomName:{text:"Plague Husk",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:34.0},{id:"minecraft:attack_damage",base:6.0},{id:"minecraft:movement_speed",base:0.26},{id:"minecraft:follow_range",base:48.0}],Health:34f,equipment:{head:{id:"minecraft:moss_carpet",count:1},mainhand:{id:"minecraft:stone_hoe",count:1}},drop_chances:{mainhand:0.0f,head:0.0f}}
execute positioned ~2.6 ~1 ~-14.8 run function ch:trials/corruption/spawn_fx
summon husk ~2.6 ~1 ~-14.8 {Tags:["ch.corruption.tn"],CustomName:{text:"Plague Husk",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:34.0},{id:"minecraft:attack_damage",base:6.0},{id:"minecraft:movement_speed",base:0.26},{id:"minecraft:follow_range",base:48.0}],Health:34f,equipment:{head:{id:"minecraft:moss_carpet",count:1},mainhand:{id:"minecraft:stone_hoe",count:1}},drop_chances:{mainhand:0.0f,head:0.0f}}
execute as @e[tag=ch.corruption.tn,distance=..40] run function ch:trials/corruption/adopt
playsound chaoshearts:trial_wave master @a[tag=ch.challenger] ~ ~ ~ 1 0.8
execute positioned ~ ~1.1 ~ run function ch:api/fx/wave {color:8114490,r:16.0,t:10}
