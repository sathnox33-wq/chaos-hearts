# Wave 1: Voidlings swarm out of the cracks, Rift Shades drift above.
execute positioned ~13.0 ~1 ~0.0 run function ch:trials/void/spawn_fx
summon endermite ~13.0 ~1 ~0.0 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~6.5 ~1 ~11.3 run function ch:trials/void/spawn_fx
summon endermite ~6.5 ~1 ~11.3 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-6.5 ~1 ~11.3 run function ch:trials/void/spawn_fx
summon endermite ~-6.5 ~1 ~11.3 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-13.0 ~1 ~0.0 run function ch:trials/void/spawn_fx
summon endermite ~-13.0 ~1 ~0.0 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~-6.5 ~1 ~-11.3 run function ch:trials/void/spawn_fx
summon endermite ~-6.5 ~1 ~-11.3 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~6.5 ~1 ~-11.3 run function ch:trials/void/spawn_fx
summon endermite ~6.5 ~1 ~-11.3 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:follow_range",base:48.0}],Health:14f}
execute positioned ~5.4 ~1 ~8.4 run function ch:trials/void/spawn_fx
summon vex ~5.4 ~1 ~8.4 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.6},{id:"minecraft:follow_range",base:48.0}],Health:12f}
execute positioned ~-5.4 ~1 ~-8.4 run function ch:trials/void/spawn_fx
summon vex ~-5.4 ~1 ~-8.4 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0},{id:"minecraft:movement_speed",base:0.6},{id:"minecraft:follow_range",base:48.0}],Health:12f}
execute as @e[tag=ch.void.tn,distance=..40] run function ch:trials/void/adopt
playsound chaoshearts:trial_wave master @a[tag=ch.challenger] ~ ~ ~ 1 0.8
execute positioned ~ ~1.1 ~ run function ch:api/fx/wave {color:9059583,r:16.0,t:10}
