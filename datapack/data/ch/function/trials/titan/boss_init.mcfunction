# Golgoth's body, gear, timers and decorations; then the trial framework adopts it as the boss.
attribute @s minecraft:max_health base set 460
attribute @s minecraft:attack_damage base set 14
attribute @s minecraft:movement_speed base set 0.25
attribute @s minecraft:scale base set 2.6
attribute @s minecraft:knockback_resistance base set 1
attribute @s minecraft:follow_range base set 64
attribute @s minecraft:step_height base set 1.5
item replace entity @s weapon.mainhand with minecraft:mace
item replace entity @s armor.head with minecraft:chiseled_stone_bricks
item replace entity @s armor.chest with minecraft:netherite_chestplate
item replace entity @s armor.legs with minecraft:iron_leggings
item replace entity @s armor.feet with minecraft:iron_boots
data merge entity @s {Health:460f,IsBaby:0b,CanBreakDoors:0b,drop_chances:{mainhand:0f,head:0f,chest:0f,legs:0f,feet:0f}}
tag @s add ch.titan.boss
scoreboard players set @s ch.t 0
scoreboard players set @s ch.phase 1
scoreboard players set @s ch.v1 80
scoreboard players set @s ch.v2 150
scoreboard players set @s ch.v3 0
scoreboard players set @s ch.v4 0
scoreboard players set @s ch.v5 200
scoreboard players set @s ch.v6 0
scoreboard players set @s ch.titan.tb1 25
function ch:api/trial/boss {name:"Golgoth, the Mountain That Walks",color:"white"}
execute rotated 0 0 summon block_display run function ch:trials/titan/deco_orbit {b:"minecraft:mossy_cobblestone"}
execute rotated 120 0 summon block_display run function ch:trials/titan/deco_orbit {b:"minecraft:cobblestone"}
execute rotated 240 0 summon block_display run function ch:trials/titan/deco_orbit {b:"minecraft:andesite"}
execute rotated 0 0 summon block_display run function ch:trials/titan/deco_crown {x:0.3,z:-0.15}
execute rotated 90 0 summon block_display run function ch:trials/titan/deco_crown {x:0.3,z:-0.15}
execute rotated 180 0 summon block_display run function ch:trials/titan/deco_crown {x:0.3,z:-0.15}
execute rotated 270 0 summon block_display run function ch:trials/titan/deco_crown {x:0.3,z:-0.15}
execute summon item_display run function ch:trials/titan/deco_core
function ch:trials/titan/entrance
