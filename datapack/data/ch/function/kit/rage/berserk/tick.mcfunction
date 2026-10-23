# Berserk running: burning fists (Chain) or a spiked crimson aura (Retaliation).
scoreboard players remove @s ch.rage.bzt 1
execute if score @s ch.rage.bzm matches 0 if score #r2 ch.tmp matches 0 anchored eyes positioned ^-0.38 ^-0.6 ^0.45 run particle minecraft:flame ~ ~ ~ 0.06 0.06 0.06 0.01 2
execute if score @s ch.rage.bzm matches 0 if score #r2 ch.tmp matches 0 anchored eyes positioned ^0.38 ^-0.6 ^0.45 run particle minecraft:dust{color:[1.0,0.42,0.12],scale:1.0} ~ ~ ~ 0.06 0.06 0.06 0 2
execute if score @s ch.rage.bzm matches 1 if score #r4 ch.tmp matches 0 run function ch:api/fx/ring {p:"minecraft:dust{color:[0.88,0.15,0.17],scale:1.1}",r:1}
execute if score @s ch.rage.bzm matches 1 if score #r4 ch.tmp matches 2 run particle minecraft:crimson_spore ~ ~1 ~ 0.6 0.6 0.6 0 6
execute if score @s ch.rage.bzt matches 0 run function ch:kit/rage/berserk/end
