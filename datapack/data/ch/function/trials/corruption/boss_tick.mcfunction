# Nyxara every tick: decorations, leash, and her attack rotation by phase.
scoreboard players add @s ch.corruption.bt 1
tp @e[type=item_display,tag=ch.corruption.bd,distance=..48] ~ ~ ~
execute as @e[type=item_display,tag=ch.corruption.bd0,distance=..3] run rotate @s ~5 ~
execute as @e[type=item_display,tag=ch.corruption.bd1,distance=..3] run rotate @s ~-3 ~
execute as @e[type=item_display,tag=ch.corruption.bd2,distance=..3] run rotate @s ~2 ~
execute if score #t20 ch.g matches 0 run particle minecraft:dust{color:[0.482,0.82,0.227],scale:1.4} ~ ~1 ~ 1.2 0.5 1.2 0 8
execute if score #t20 ch.g matches 10 run particle minecraft:item_slime ~ ~1 ~ 1 0.4 1 0.05 6
execute unless entity @e[type=marker,tag=ch.session,distance=..26,limit=1] at @e[type=marker,tag=ch.session,limit=1,sort=nearest] run tp @s ~ ~1 ~
scoreboard players operation #cb ch.tmp = @s ch.corruption.bt
scoreboard players operation #cb ch.tmp %= #100 ch.corruption.k
execute if score #cb ch.tmp matches 30 run function ch:trials/corruption/spit
scoreboard players operation #cb ch.tmp = @s ch.corruption.bt
scoreboard players operation #cb ch.tmp %= #160 ch.corruption.k
execute if score #cb ch.tmp matches 90 run function ch:trials/corruption/snare
scoreboard players operation #cb ch.tmp = @s ch.corruption.bt
scoreboard players operation #cb ch.tmp %= #180 ch.corruption.k
execute if score @s ch.corruption.bp matches 2.. if score #cb ch.tmp matches 60 run function ch:trials/corruption/pustules
scoreboard players operation #cb ch.tmp = @s ch.corruption.bt
scoreboard players operation #cb ch.tmp %= #300 ch.corruption.k
execute if score @s ch.corruption.bp matches 2.. if score #cb ch.tmp matches 150 run function ch:trials/corruption/brood
execute if score @s ch.corruption.bp matches 3.. run scoreboard players add @s ch.v2 1
