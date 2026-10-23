# Wave 2: more wings, callers and Gale Wisps.
summon minecraft:phantom ~13 ~9 ~5 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~13 ~1 ~5 0.4 0.8 0.4 0.2 25
summon minecraft:phantom ~-5 ~9 ~13 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~-5 ~1 ~13 0.4 0.8 0.4 0.2 25
summon minecraft:phantom ~-13 ~9 ~-5 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~-13 ~1 ~-5 0.4 0.8 0.4 0.2 25
summon minecraft:phantom ~5 ~9 ~-13 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~5 ~1 ~-13 0.4 0.8 0.4 0.2 25
summon minecraft:skeleton ~17 ~ ~0 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormcaller",color:"#4FA8FF"},CustomNameVisible:1b,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:chainmail_helmet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f},attributes:[{id:"minecraft:max_health",base:26.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:armor",base:2.0}],Health:26.0f}
particle minecraft:electric_spark ~17 ~1 ~0 0.4 0.8 0.4 0.2 25
summon minecraft:skeleton ~-17 ~ ~0 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormcaller",color:"#4FA8FF"},CustomNameVisible:1b,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:chainmail_helmet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f},attributes:[{id:"minecraft:max_health",base:26.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:armor",base:2.0}],Health:26.0f}
particle minecraft:electric_spark ~-17 ~1 ~0 0.4 0.8 0.4 0.2 25
summon minecraft:breeze ~4 ~1 ~9 {Tags:["ch.storm.tnew"],CustomName:{text:"Gale Wisp",color:"#E8F6FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:24.0}],Health:24.0f}
particle minecraft:electric_spark ~4 ~1 ~9 0.4 0.8 0.4 0.2 25
summon minecraft:breeze ~-4 ~1 ~-9 {Tags:["ch.storm.tnew"],CustomName:{text:"Gale Wisp",color:"#E8F6FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:24.0}],Health:24.0f}
particle minecraft:electric_spark ~-4 ~1 ~-9 0.4 0.8 0.4 0.2 25
execute as @e[tag=ch.storm.tnew,distance=..60] run function ch:api/trial/adopt
tag @e[tag=ch.storm.tnew,distance=..60] remove ch.storm.tnew
