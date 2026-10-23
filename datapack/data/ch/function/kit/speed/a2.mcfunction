# Afterimage. Level: vanish (armour too) and leave a decoy. Up: Mirror Feint, the decoy sprints ahead and explodes.
# Down: Shade Ambush, your first strike from hiding roots the target and echoes as a sonic boom.
execute if score @s ch.speed.van matches 1.. run return fail
scoreboard players set #dur ch.speed.g 60
execute if score @s ch.b2 matches 1.. run scoreboard players set #dur ch.speed.g 84
execute if score #var ch.tmp matches 1 run scoreboard players set #dur ch.speed.g 40
execute if score #var ch.tmp matches 1 if score @s ch.b2 matches 1.. run scoreboard players set #dur ch.speed.g 56
scoreboard players operation @s ch.speed.vmode = #var ch.tmp
function ch:kit/speed/van/decoy
function ch:kit/speed/van/start
execute if score @s ch.b2 matches 4.. run function ch:api/cooldown {slot:2,t:300}
return 1
