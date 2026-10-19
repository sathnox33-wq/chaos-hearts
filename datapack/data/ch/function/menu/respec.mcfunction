# Refunds every node of the active heart's tree. The first respec is free, later ones cost XP levels.
execute unless function ch:menu/load run return run function ch:menu/main
execute if score @s ch.b1 matches 0 if score @s ch.b2 matches 0 if score @s ch.b3 matches 0 run return run function ch:menu/tree
execute store result score #lv ch.tmp run xp query @s levels
execute if score @s ch.respec matches 1.. if score #lv ch.tmp < #respec_lvls ch.cfg run return run function ch:menu/respec_fail
execute if score @s ch.respec matches 1.. run function ch:menu/respec_pay with storage ch:tmp h
scoreboard players add @s ch.respec 1
function ch:gen/unequip
function ch:menu/respec2 with storage ch:tmp h
function ch:gen/sync_active
function ch:gen/equip
playsound minecraft:block.enchantment_table.use player @s ~ ~ ~ 1 0.8
function ch:menu/tree
