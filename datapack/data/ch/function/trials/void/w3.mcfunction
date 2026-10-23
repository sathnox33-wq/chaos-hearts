# Wave 3: Null Knights march out of the dark with Watchers and Shades.
execute positioned ~14.7 ~1 ~3.0 run function ch:trials/void/spawn_fx
summon wither_skeleton ~14.7 ~1 ~3.0 {Tags:["ch.void.tn"],CustomName:{text:"Null Knight",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:40.0},{id:"minecraft:attack_damage",base:9.0},{id:"minecraft:movement_speed",base:0.28},{id:"minecraft:follow_range",base:48.0}],Health:40f,equipment:{mainhand:{id:"minecraft:netherite_sword",count:1},head:{id:"minecraft:leather_helmet",count:1,components:{"minecraft:dyed_color":9059583}},chest:{id:"minecraft:leather_chestplate",count:1,components:{"minecraft:dyed_color":1310763}}},drop_chances:{mainhand:0.0f,head:0.0f,chest:0.0f}}
execute positioned ~-14.7 ~1 ~-3.0 run function ch:trials/void/spawn_fx
summon wither_skeleton ~-14.7 ~1 ~-3.0 {Tags:["ch.void.tn"],CustomName:{text:"Null Knight",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:40.0},{id:"minecraft:attack_damage",base:9.0},{id:"minecraft:movement_speed",base:0.28},{id:"minecraft:follow_range",base:48.0}],Health:40f,equipment:{mainhand:{id:"minecraft:netherite_sword",count:1},head:{id:"minecraft:leather_helmet",count:1,components:{"minecraft:dyed_color":9059583}},chest:{id:"minecraft:leather_chestplate",count:1,components:{"minecraft:dyed_color":1310763}}},drop_chances:{mainhand:0.0f,head:0.0f,chest:0.0f}}
execute positioned ~6.2 ~1 ~15.8 run function ch:trials/void/spawn_fx
summon enderman ~6.2 ~1 ~15.8 {Tags:["ch.void.tn"],CustomName:{text:"Hollow Watcher",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:44.0},{id:"minecraft:attack_damage",base:7.0},{id:"minecraft:movement_speed",base:0.32},{id:"minecraft:follow_range",base:48.0}],Health:44f,carriedBlockState:{Name:"minecraft:obsidian"}}
execute positioned ~-16.8 ~1 ~-2.6 run function ch:trials/void/spawn_fx
summon enderman ~-16.8 ~1 ~-2.6 {Tags:["ch.void.tn"],CustomName:{text:"Hollow Watcher",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:44.0},{id:"minecraft:attack_damage",base:7.0},{id:"minecraft:movement_speed",base:0.32},{id:"minecraft:follow_range",base:48.0}],Health:44f,carriedBlockState:{Name:"minecraft:obsidian"}}
execute positioned ~10.6 ~1 ~-13.3 run function ch:trials/void/spawn_fx
summon enderman ~10.6 ~1 ~-13.3 {Tags:["ch.void.tn"],CustomName:{text:"Hollow Watcher",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:44.0},{id:"minecraft:attack_damage",base:7.0},{id:"minecraft:movement_speed",base:0.32},{id:"minecraft:follow_range",base:48.0}],Health:44f,carriedBlockState:{Name:"minecraft:obsidian"}}
execute positioned ~7.9 ~1 ~4.3 run function ch:trials/void/spawn_fx
summon vex ~7.9 ~1 ~4.3 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.6},{id:"minecraft:follow_range",base:48.0}],Health:12f}
execute positioned ~-7.7 ~1 ~4.7 run function ch:trials/void/spawn_fx
summon vex ~-7.7 ~1 ~4.7 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.6},{id:"minecraft:follow_range",base:48.0}],Health:12f}
execute positioned ~-0.2 ~1 ~-9.0 run function ch:trials/void/spawn_fx
summon vex ~-0.2 ~1 ~-9.0 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.6},{id:"minecraft:follow_range",base:48.0}],Health:12f}
execute as @e[tag=ch.void.tn,distance=..40] run function ch:trials/void/adopt
playsound chaoshearts:trial_wave master @a[tag=ch.challenger] ~ ~ ~ 1 0.8
execute positioned ~ ~1.1 ~ run function ch:api/fx/wave {color:9059583,r:16.0,t:10}
