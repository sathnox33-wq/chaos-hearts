# Wave 3: the Thunderborn arrive with the wind.
summon minecraft:stray ~16 ~ ~0 {Tags:["ch.storm.tnew"],CustomName:{text:"Thunderborn",color:"#9B7BFF"},CustomNameVisible:1b,equipment:{mainhand:{id:"minecraft:trident",count:1},head:{id:"minecraft:golden_helmet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f},attributes:[{id:"minecraft:max_health",base:34.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:attack_damage",base:6.0},{id:"minecraft:armor",base:4.0}],Health:34.0f}
particle minecraft:electric_spark ~16 ~1 ~0 0.4 0.8 0.4 0.2 25
summon minecraft:stray ~-8 ~ ~14 {Tags:["ch.storm.tnew"],CustomName:{text:"Thunderborn",color:"#9B7BFF"},CustomNameVisible:1b,equipment:{mainhand:{id:"minecraft:trident",count:1},head:{id:"minecraft:golden_helmet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f},attributes:[{id:"minecraft:max_health",base:34.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:attack_damage",base:6.0},{id:"minecraft:armor",base:4.0}],Health:34.0f}
particle minecraft:electric_spark ~-8 ~1 ~14 0.4 0.8 0.4 0.2 25
summon minecraft:stray ~-8 ~ ~-14 {Tags:["ch.storm.tnew"],CustomName:{text:"Thunderborn",color:"#9B7BFF"},CustomNameVisible:1b,equipment:{mainhand:{id:"minecraft:trident",count:1},head:{id:"minecraft:golden_helmet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f},attributes:[{id:"minecraft:max_health",base:34.0},{id:"minecraft:movement_speed",base:0.3},{id:"minecraft:attack_damage",base:6.0},{id:"minecraft:armor",base:4.0}],Health:34.0f}
particle minecraft:electric_spark ~-8 ~1 ~-14 0.4 0.8 0.4 0.2 25
summon minecraft:phantom ~11 ~9 ~6 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~11 ~1 ~6 0.4 0.8 0.4 0.2 25
summon minecraft:phantom ~-10 ~9 ~6 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~-10 ~1 ~6 0.4 0.8 0.4 0.2 25
summon minecraft:phantom ~0 ~9 ~-12 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~0 ~1 ~-12 0.4 0.8 0.4 0.2 25
summon minecraft:breeze ~8 ~1 ~0 {Tags:["ch.storm.tnew"],CustomName:{text:"Gale Wisp",color:"#E8F6FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:24.0}],Health:24.0f}
particle minecraft:electric_spark ~8 ~1 ~0 0.4 0.8 0.4 0.2 25
summon minecraft:breeze ~-8 ~1 ~0 {Tags:["ch.storm.tnew"],CustomName:{text:"Gale Wisp",color:"#E8F6FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:24.0}],Health:24.0f}
particle minecraft:electric_spark ~-8 ~1 ~0 0.4 0.8 0.4 0.2 25
execute as @e[tag=ch.storm.tnew,distance=..60] run function ch:api/trial/adopt
tag @e[tag=ch.storm.tnew,distance=..60] remove ch.storm.tnew
