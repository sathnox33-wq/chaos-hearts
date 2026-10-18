scoreboard players operation #h ch.tmp = @s ch.hid
scoreboard players set #found ch.tmp 0
execute as @e[type=item_display,tag=ch.token,distance=..2] if score @s ch.hid = #h ch.tmp run scoreboard players set #found ch.tmp 1
execute if score #found ch.tmp matches 0 run kill @s
