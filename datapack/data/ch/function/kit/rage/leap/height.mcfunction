# Dive damage from the height fallen since the apex (#ld ch.tmp in tenths).
execute store result score #y ch.tmp run data get entity @s Pos[1] 10
scoreboard players operation #h ch.tmp = @s ch.rage.ly
scoreboard players operation #h ch.tmp -= #y ch.tmp
execute if score #h ch.tmp matches ..0 run scoreboard players set #h ch.tmp 0
execute if score @s ch.rage.lv matches 1 run scoreboard players operation #h ch.tmp /= #2 ch.g
execute if score @s ch.rage.lv matches 3 run scoreboard players operation #h ch.tmp *= #3 ch.rage.g
execute if score @s ch.rage.lv matches 3 run scoreboard players operation #h ch.tmp /= #10 ch.g
execute if score @s ch.rage.lv matches 3 run scoreboard players set #ld ch.tmp 90
scoreboard players operation #ld ch.tmp += #h ch.tmp
execute if score #ld ch.tmp matches 151.. run scoreboard players set #ld ch.tmp 150
