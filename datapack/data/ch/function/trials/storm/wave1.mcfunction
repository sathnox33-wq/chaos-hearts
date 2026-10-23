# Wave 1: Stormwings circle overhead while Stormcallers take aim.
summon minecraft:phantom ~14 ~9 ~0 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~14 ~1 ~0 0.4 0.8 0.4 0.2 25
summon minecraft:phantom ~-7 ~9 ~12 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~-7 ~1 ~12 0.4 0.8 0.4 0.2 25
summon minecraft:phantom ~-7 ~9 ~-12 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormwing",color:"#4FA8FF"},CustomNameVisible:1b,attributes:[{id:"minecraft:max_health",base:20.0},{id:"minecraft:attack_damage",base:5.0},{id:"minecraft:scale",base:1.3}],Health:20.0f}
particle minecraft:electric_spark ~-7 ~1 ~-12 0.4 0.8 0.4 0.2 25
summon minecraft:skeleton ~12 ~ ~12 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormcaller",color:"#4FA8FF"},CustomNameVisible:1b,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:chainmail_helmet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f},attributes:[{id:"minecraft:max_health",base:26.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:armor",base:2.0}],Health:26.0f}
particle minecraft:electric_spark ~12 ~1 ~12 0.4 0.8 0.4 0.2 25
summon minecraft:skeleton ~-12 ~ ~-12 {Tags:["ch.storm.tnew"],CustomName:{text:"Stormcaller",color:"#4FA8FF"},CustomNameVisible:1b,equipment:{mainhand:{id:"minecraft:bow",count:1},head:{id:"minecraft:chainmail_helmet",count:1}},drop_chances:{mainhand:0.0f,head:0.0f},attributes:[{id:"minecraft:max_health",base:26.0},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:armor",base:2.0}],Health:26.0f}
particle minecraft:electric_spark ~-12 ~1 ~-12 0.4 0.8 0.4 0.2 25
execute as @e[tag=ch.storm.tnew,distance=..60] run function ch:api/trial/adopt
tag @e[tag=ch.storm.tnew,distance=..60] remove ch.storm.tnew
