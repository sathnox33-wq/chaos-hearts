# Panel: makes heart #c - 2200 the picked player's active heart (if they hold one).
scoreboard players operation #ai ch.tmp = #c ch.tmp
scoreboard players remove #ai ch.tmp 2200
execute store result storage ch:tmp am.i int 1 run scoreboard players get #ai ch.tmp
execute as @a[tag=ch.adtgt,limit=1] run function ch:heart/set_active with storage ch:tmp am
tellraw @s {text:"Active heart changed.",color:"gray"}
