# Wave 1: Blightlings boil up out of the moss.
execute positioned ~14.0 ~1 ~0.0 run function ch:trials/corruption/spawn_fx
summon cave_spider ~14.0 ~1 ~0.0 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~7.0 ~1 ~12.1 run function ch:trials/corruption/spawn_fx
summon cave_spider ~7.0 ~1 ~12.1 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-7.0 ~1 ~12.1 run function ch:trials/corruption/spawn_fx
summon cave_spider ~-7.0 ~1 ~12.1 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-14.0 ~1 ~0.0 run function ch:trials/corruption/spawn_fx
summon cave_spider ~-14.0 ~1 ~0.0 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-7.0 ~1 ~-12.1 run function ch:trials/corruption/spawn_fx
summon cave_spider ~-7.0 ~1 ~-12.1 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~7.0 ~1 ~-12.1 run function ch:trials/corruption/spawn_fx
summon cave_spider ~7.0 ~1 ~-12.1 {Tags:["ch.corruption.tn"],CustomName:{text:"Blightling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:3.0},{id:"minecraft:movement_speed",base:0.34},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute as @e[tag=ch.corruption.tn,distance=..40] run function ch:trials/corruption/adopt
playsound chaoshearts:trial_wave master @a[tag=ch.challenger] ~ ~ ~ 1 0.8
execute positioned ~ ~1.1 ~ run function ch:api/fx/wave {color:8114490,r:16.0,t:10}
