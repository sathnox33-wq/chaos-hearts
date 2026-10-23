# Wave 2: more Voidlings and Shades, and the Hollow Watchers open their eyes.
execute positioned ~12.0 ~1 ~5.1 run function ch:trials/void/spawn_fx
summon endermite ~12.0 ~1 ~5.1 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-5.1 ~1 ~12.0 run function ch:trials/void/spawn_fx
summon endermite ~-5.1 ~1 ~12.0 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-12.0 ~1 ~-5.1 run function ch:trials/void/spawn_fx
summon endermite ~-12.0 ~1 ~-5.1 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~5.1 ~1 ~-12.0 run function ch:trials/void/spawn_fx
summon endermite ~5.1 ~1 ~-12.0 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~6.2 ~1 ~7.8 run function ch:trials/void/spawn_fx
summon vex ~6.2 ~1 ~7.8 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.6},{id:"minecraft:follow_range",base:48.0}],Health:12f}
execute positioned ~-9.9 ~1 ~1.5 run function ch:trials/void/spawn_fx
summon vex ~-9.9 ~1 ~1.5 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.6},{id:"minecraft:follow_range",base:48.0}],Health:12f}
execute positioned ~3.7 ~1 ~-9.3 run function ch:trials/void/spawn_fx
summon vex ~3.7 ~1 ~-9.3 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.6},{id:"minecraft:follow_range",base:48.0}],Health:12f}
execute positioned ~-0.5 ~1 ~16.0 run function ch:trials/void/spawn_fx
summon enderman ~-0.5 ~1 ~16.0 {Tags:["ch.void.tn"],CustomName:{text:"Hollow Watcher",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:44.0},{id:"minecraft:attack_damage",base:7.0},{id:"minecraft:movement_speed",base:0.32},{id:"minecraft:follow_range",base:48.0}],Health:44f,carriedBlockState:{Name:"minecraft:crying_obsidian"}}
execute positioned ~0.5 ~1 ~-16.0 run function ch:trials/void/spawn_fx
summon enderman ~0.5 ~1 ~-16.0 {Tags:["ch.void.tn"],CustomName:{text:"Hollow Watcher",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:44.0},{id:"minecraft:attack_damage",base:7.0},{id:"minecraft:movement_speed",base:0.32},{id:"minecraft:follow_range",base:48.0}],Health:44f,carriedBlockState:{Name:"minecraft:crying_obsidian"}}
execute as @e[tag=ch.void.tn,distance=..40] run function ch:trials/void/adopt
playsound chaoshearts:trial_wave master @a[tag=ch.challenger] ~ ~ ~ 1 0.8
execute positioned ~ ~1.1 ~ run function ch:api/fx/wave {color:9059583,r:16.0,t:10}
