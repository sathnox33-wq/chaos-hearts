# One marked enemy, every tick.
scoreboard players remove @s ch.rage.mk 1
scoreboard players set #rmk ch.rage.g 1
execute if score #t20 ch.g matches 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.6} ~ ~2.3 ~ 0.15 0.05 0.15 0 6
execute if score #t20 ch.g matches 10 run particle minecraft:angry_villager ~ ~2.3 ~ 0.1 0.1 0.1 0 1
execute if score @s ch.rage.mk matches ..0 run tag @s remove ch.rage.marked
