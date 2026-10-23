# Wave 2: Blightlings and Rotting Archers on the mud ring.
execute positioned ~12.0 ~1 ~5.1 run function ch:trials/corruption/spawn_fx
summon cave_spider ~12.0 ~1 ~5.1 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-5.1 ~1 ~12.0 run function ch:trials/corruption/spawn_fx
summon cave_spider ~-5.1 ~1 ~12.0 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-12.0 ~1 ~-5.1 run function ch:trials/corruption/spawn_fx
summon cave_spider ~-12.0 ~1 ~-5.1 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~5.1 ~1 ~-12.0 run function ch:trials/corruption/spawn_fx
summon cave_spider ~5.1 ~1 ~-12.0 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~9.7 ~1 ~15.1 run function ch:trials/corruption/spawn_fx
summon bogged ~9.7 ~1 ~15.1 {Tags:["ch.corruption.tn"],CustomName:{text:"Rotting Archer",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:24.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:follow_range",base:48.0}],Health:24f,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:moss_carpet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f}}
execute positioned ~-18.0 ~1 ~0.8 run function ch:trials/corruption/spawn_fx
summon bogged ~-18.0 ~1 ~0.8 {Tags:["ch.corruption.tn"],CustomName:{text:"Rotting Archer",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:24.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:follow_range",base:48.0}],Health:24f,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:moss_carpet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f}}
execute positioned ~8.3 ~1 ~-16.0 run function ch:trials/corruption/spawn_fx
summon bogged ~8.3 ~1 ~-16.0 {Tags:["ch.corruption.tn"],CustomName:{text:"Rotting Archer",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:24.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:follow_range",base:48.0}],Health:24f,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:moss_carpet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f}}
execute as @e[tag=ch.corruption.tn,distance=..40] run function ch:trials/corruption/adopt
playsound chaoshearts:trial_wave master @a[tag=ch.challenger] ~ ~ ~ 1 0.8
execute positioned ~ ~1.1 ~ run function ch:api/fx/wave {color:8114490,r:16.0,t:10}
