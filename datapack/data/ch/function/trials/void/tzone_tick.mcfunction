# As an open crack: pulls light in and hurts the challenger standing in it.
scoreboard players remove @s ch.life 1
particle minecraft:portal ~ ~0.3 ~ 1.5 0.1 1.5 0.3 6
particle minecraft:dust{color:[0.039,0.0,0.078],scale:1.6} ~ ~0.2 ~ 1.5 0.05 1.5 0 3
scoreboard players operation #vb ch.tmp = @s ch.life
scoreboard players operation #vb ch.tmp %= #20 ch.g
execute if score #vb ch.tmp matches 0 as @a[tag=ch.challenger,distance=..3] run function ch:trials/void/strike {d:40}
execute if score @s ch.life matches ..0 run kill @s
