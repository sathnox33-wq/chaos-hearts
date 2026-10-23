# The vault tagged ch.speed.vthis goes back on the player (or on the ground if they are dead or wearing something new).
attribute @s minecraft:armor modifier remove ch:speed_ghost
attribute @s minecraft:armor_toughness modifier remove ch:speed_ghost
execute store result score #hp ch.speed.g run data get entity @s Health 100
scoreboard players set #dead ch.speed.g 0
execute if score #hp ch.speed.g matches ..0 run scoreboard players set #dead ch.speed.g 1
function ch:kit/speed/van/slot {s:"armor.head"}
function ch:kit/speed/van/slot {s:"armor.chest"}
function ch:kit/speed/van/slot {s:"armor.legs"}
function ch:kit/speed/van/slot {s:"armor.feet"}
kill @e[type=armor_stand,tag=ch.speed.vthis]
