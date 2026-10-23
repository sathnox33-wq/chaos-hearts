# Moves vault slot $(s) back to the player, dropping it at their feet when they are dead or the slot is taken.
$execute unless items entity @e[type=armor_stand,tag=ch.speed.vthis,limit=1] $(s) * run return 0
$execute if score #dead ch.speed.g matches 1 run function ch:kit/speed/van/drop {s:"$(s)"}
$execute if score #dead ch.speed.g matches 0 if items entity @s $(s) * run function ch:kit/speed/van/drop {s:"$(s)"}
$execute if score #dead ch.speed.g matches 0 unless items entity @s $(s) * run item replace entity @s $(s) from entity @e[type=armor_stand,tag=ch.speed.vthis,limit=1] $(s)
$item replace entity @e[type=armor_stand,tag=ch.speed.vthis,limit=1] $(s) with minecraft:air
