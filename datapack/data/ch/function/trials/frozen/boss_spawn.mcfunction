# Hrimvald steps down from the blue throne: a giant stray in diamond, crowned with icicles, shards of ice circling him.
summon minecraft:stray ~ ~ ~-14 {Tags:["ch.tmob","ch.frozen.boss","ch.frozen.bnew"],CustomName:{text:"Hrimvald, the Last Winter",color:"#9BE7FF",bold:true},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:scale",base:2.0},{id:"minecraft:max_health",base:380},{id:"minecraft:attack_damage",base:10},{id:"minecraft:movement_speed",base:0.27},{id:"minecraft:knockback_resistance",base:0.8},{id:"minecraft:follow_range",base:64}],Health:380f,equipment:{mainhand:{id:"minecraft:bow",count:1,components:{"minecraft:enchantments":{"minecraft:power":3}}},head:{id:"minecraft:diamond_helmet",count:1,components:{"minecraft:trim":{material:"minecraft:quartz",pattern:"minecraft:spire"}}},chest:{id:"minecraft:diamond_chestplate",count:1,components:{"minecraft:trim":{material:"minecraft:quartz",pattern:"minecraft:spire"}}},legs:{id:"minecraft:leather_leggings",count:1,components:{"minecraft:dyed_color":15924223}}},drop_chances:{mainhand:0.0f,head:0.0f,chest:0.0f,legs:0.0f}}
execute as @e[tag=ch.frozen.bnew,limit=1] run function ch:api/trial/boss {name:"Hrimvald, the Last Winter",color:"blue"}
scoreboard players set @e[tag=ch.frozen.bnew,limit=1] ch.frozen.bt 0
scoreboard players set @e[tag=ch.frozen.bnew,limit=1] ch.frozen.ph 1
scoreboard players set @e[tag=ch.frozen.bnew,limit=1] ch.frozen.zero 0
execute at @e[tag=ch.frozen.bnew,limit=1] run function ch:trials/frozen/boss_deco
execute at @e[tag=ch.frozen.bnew,limit=1] run function ch:trials/frozen/boss_entrance
tag @e[tag=ch.frozen.bnew] remove ch.frozen.bnew
