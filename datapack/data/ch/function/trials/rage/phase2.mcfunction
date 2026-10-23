# Phase 2: Gorrath swells with fury and calls two Thralls.
attribute @s minecraft:scale base set 1.7
scoreboard players set @s ch.v4 30
function ch:api/fx/wave {color:14689835,r:12.0,t:10}
function ch:api/fx/pillar {model:"beam",color:14689835,w:3.0,h:20.0,t:4,life:20}
particle minecraft:dust{color:[0.88,0.15,0.17],scale:3.0} ~ ~2 ~ 2 2 2 0 100
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 3 0.5
function ch:trials/rage/say {m:"Gorrath's blood boils. The sky begins to burn."}
summon minecraft:vindicator ~4 ~ ~ {Tags:["ch.rage.new","ch.rage.mob"],PersistenceRequired:1b,CustomName:{text:"Fury Thrall",color:"#E0262B"},equipment:{mainhand:{id:"minecraft:iron_axe",count:1}},drop_chances:{mainhand:0.0f},attributes:[{id:"minecraft:max_health",base:30.0},{id:"minecraft:attack_damage",base:7.0},{id:"minecraft:follow_range",base:48.0}],Health:30.0f}
summon minecraft:vindicator ~-4 ~ ~ {Tags:["ch.rage.new","ch.rage.mob"],PersistenceRequired:1b,CustomName:{text:"Fury Thrall",color:"#E0262B"},equipment:{mainhand:{id:"minecraft:iron_axe",count:1}},drop_chances:{mainhand:0.0f},attributes:[{id:"minecraft:max_health",base:30.0},{id:"minecraft:attack_damage",base:7.0},{id:"minecraft:follow_range",base:48.0}],Health:30.0f}
execute as @e[tag=ch.rage.new,distance=..20] run function ch:api/trial/adopt
execute as @e[tag=ch.rage.new,distance=..20] at @s run function ch:trials/rage/spawn_fx
tag @e[tag=ch.rage.new] remove ch.rage.new
