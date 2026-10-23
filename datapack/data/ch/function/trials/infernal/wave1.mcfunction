# Wave 1: Cinderlings (blazes) and Molten Husks.
summon minecraft:blaze ~14 ~3 ~0 {Tags:["ch.tmob","ch.infernal.tm","ch.infernal.tnew"],CustomName:{text:"Cinderling",color:"#FF7A1A"},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:max_health",base:22},{id:"minecraft:follow_range",base:48}],Health:22f}
summon minecraft:blaze ~-7 ~3 ~12 {Tags:["ch.tmob","ch.infernal.tm","ch.infernal.tnew"],CustomName:{text:"Cinderling",color:"#FF7A1A"},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:max_health",base:22},{id:"minecraft:follow_range",base:48}],Health:22f}
summon minecraft:blaze ~-7 ~3 ~-12 {Tags:["ch.tmob","ch.infernal.tm","ch.infernal.tnew"],CustomName:{text:"Cinderling",color:"#FF7A1A"},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:max_health",base:22},{id:"minecraft:follow_range",base:48}],Health:22f}
summon minecraft:magma_cube ~0 ~0 ~10 {Tags:["ch.tmob","ch.infernal.tm","ch.infernal.tnew"],CustomName:{text:"Molten Husk",color:"#FF7A1A"},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:max_health",base:16},{id:"minecraft:follow_range",base:48}],Health:16f,Size:1}
summon minecraft:magma_cube ~0 ~0 ~-10 {Tags:["ch.tmob","ch.infernal.tm","ch.infernal.tnew"],CustomName:{text:"Molten Husk",color:"#FF7A1A"},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:max_health",base:16},{id:"minecraft:follow_range",base:48}],Health:16f,Size:1}
execute as @e[tag=ch.infernal.tnew,distance=..60] at @s run function ch:trials/infernal/spawn_fx
execute as @e[tag=ch.infernal.tnew,distance=..60] run function ch:api/trial/adopt
tag @e[tag=ch.infernal.tnew] remove ch.infernal.tnew
