# Two Voidlings and a Rift Shade join the fight.
summon endermite ~4 ~1 ~0 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0}],Health:14f}
summon endermite ~-4 ~1 ~0 {Tags:["ch.void.tn"],CustomName:{text:"Voidling",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:14.0},{id:"minecraft:attack_damage",base:4.0}],Health:14f}
summon vex ~0 ~3 ~4 {Tags:["ch.void.tn"],CustomName:{text:"Rift Shade",color:"#8A3CFF"},attributes:[{id:"minecraft:max_health",base:12.0},{id:"minecraft:attack_damage",base:4.0}],Health:12f}
execute positioned ~4 ~1 ~0 run function ch:trials/void/spawn_fx
execute positioned ~-4 ~1 ~0 run function ch:trials/void/spawn_fx
execute positioned ~0 ~3 ~4 run function ch:trials/void/spawn_fx
execute as @e[tag=ch.void.tn,distance=..20] run function ch:trials/void/adopt
