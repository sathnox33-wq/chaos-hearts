$scoreboard players set #b ch.tmp $(b)
scoreboard players set #add ch.tmp 1
execute if score #b ch.tmp matches 2 run scoreboard players set #add ch.tmp 10
execute if score #b ch.tmp matches 3 run scoreboard players set #add ch.tmp 100
function ch:menu/take3 with storage ch:tmp h
function ch:gen/unequip
function ch:gen/sync_active
function ch:gen/equip
playsound chaoshearts:skill_unlock player @s ~ ~ ~ 1 1
particle minecraft:totem_of_undying ~ ~1 ~ 0.4 0.6 0.4 0.3 40
function ch:menu/tree
