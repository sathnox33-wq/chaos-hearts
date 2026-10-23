# Ignaroth rises before his throne: a giant wither skeleton in netherite and gold, crowned with fire and circled by molten orbs.
summon minecraft:wither_skeleton ~ ~ ~-14 {Tags:["ch.tmob","ch.infernal.boss","ch.infernal.bnew"],CustomName:{text:"Ignaroth, Lord of Cinders",color:"#FF7A1A",bold:true},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:scale",base:1.8},{id:"minecraft:max_health",base:380},{id:"minecraft:attack_damage",base:9},{id:"minecraft:movement_speed",base:0.28},{id:"minecraft:knockback_resistance",base:0.8},{id:"minecraft:follow_range",base:64}],Health:380f,equipment:{mainhand:{id:"minecraft:netherite_sword",count:1,components:{"minecraft:enchantments":{"minecraft:fire_aspect":2}}},head:{id:"minecraft:golden_helmet",count:1},chest:{id:"minecraft:netherite_chestplate",count:1,components:{"minecraft:trim":{material:"minecraft:gold",pattern:"minecraft:rib"}}},legs:{id:"minecraft:netherite_leggings",count:1},feet:{id:"minecraft:netherite_boots",count:1}},drop_chances:{mainhand:0.0f,head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f}}
execute as @e[tag=ch.infernal.bnew,limit=1] run function ch:api/trial/boss {name:"Ignaroth, Lord of Cinders",color:"yellow"}
scoreboard players set @e[tag=ch.infernal.bnew,limit=1] ch.infernal.bt 0
scoreboard players set @e[tag=ch.infernal.bnew,limit=1] ch.infernal.ph 1
execute at @e[tag=ch.infernal.bnew,limit=1] run function ch:trials/infernal/boss_deco
execute at @e[tag=ch.infernal.bnew,limit=1] run function ch:trials/infernal/boss_entrance
tag @e[tag=ch.infernal.bnew] remove ch.infernal.bnew
