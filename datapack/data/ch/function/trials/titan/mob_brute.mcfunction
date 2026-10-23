# Quarry Brute: a hulking husk with an iron pick and a stone helm.
attribute @s minecraft:max_health base set 36
attribute @s minecraft:attack_damage base set 7
attribute @s minecraft:movement_speed base set 0.24
attribute @s minecraft:scale base set 1.25
attribute @s minecraft:knockback_resistance base set 0.4
attribute @s minecraft:follow_range base set 48
item replace entity @s weapon.mainhand with minecraft:iron_pickaxe
item replace entity @s armor.head with minecraft:chiseled_stone_bricks
item replace entity @s armor.chest with minecraft:iron_chestplate
data merge entity @s {CustomName:{text:"Quarry Brute",color:"#C9A45C"},Health:36f,IsBaby:0b,drop_chances:{mainhand:0f,head:0f,chest:0f}}
function ch:api/trial/adopt
function ch:trials/titan/spawn_fx
