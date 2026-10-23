# Gives the player back the armour in their vault.
attribute @s minecraft:armor modifier remove ch:speed_ghost
attribute @s minecraft:armor_toughness modifier remove ch:speed_ghost
scoreboard players operation #pid ch.speed.g = @s ch.pid
function ch:kit/speed/van/find
execute if entity @e[type=armor_stand,tag=ch.speed.vthis,limit=1] run function ch:kit/speed/van/unvault_found
