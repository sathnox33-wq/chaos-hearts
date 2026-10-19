# The next extra heart (#k): full, half or empty from current health, glowing if it is the active heart's type.
execute if score #k ch.tmp matches 10.. run return 0
scoreboard players add #k ch.tmp 1
scoreboard players operation #th ch.tmp = #k ch.tmp
scoreboard players operation #th ch.tmp *= #2 ch.g
scoreboard players add #th ch.tmp 20
scoreboard players set #st ch.tmp 2
execute if score @s ch.health >= #th ch.tmp run scoreboard players set #st ch.tmp 0
scoreboard players remove #th ch.tmp 1
execute if score @s ch.health = #th ch.tmp run scoreboard players set #st ch.tmp 1
$execute if score @s ch.active matches $(i) if score #st ch.tmp matches 0 run scoreboard players set #st ch.tmp 3
$execute if score @s ch.active matches $(i) if score #st ch.tmp matches 3 if score #pulse ch.tmp matches 1 run scoreboard players set #st ch.tmp 5
$execute if score @s ch.active matches $(i) if score #st ch.tmp matches 1 run scoreboard players set #st ch.tmp 4
$scoreboard players set #c ch.tmp $(i)
scoreboard players remove #c ch.tmp 1
scoreboard players operation #c ch.tmp *= #8 ch.g
scoreboard players operation #c ch.tmp += #st ch.tmp
execute store result storage ch:tmp n.c int 1 run scoreboard players get #c ch.tmp
function ch:core/hud/heart_put with storage ch:tmp n
