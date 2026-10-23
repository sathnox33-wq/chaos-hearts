# Fury rose to 50: melee hits deal 10% more; Thick Skin hardens you.
scoreboard players set @s ch.rage.s50 1
attribute @s minecraft:attack_damage modifier add ch:rage_fury 0.1 add_multiplied_total
execute if score @s ch.b2 matches 1.. run attribute @s minecraft:armor modifier add ch:rage_thick 2 add_value
execute if score @s ch.b2 matches 1.. run attribute @s minecraft:armor_toughness modifier add ch:rage_thick 1 add_value
playsound minecraft:item.firecharge.use player @s ~ ~ ~ 0.4 0.6
particle minecraft:flame ~ ~1 ~ 0.3 0.5 0.3 0.03 12
