# As a projectile entering the field (not the owner's): it nearly stops and hangs, glittering.
execute on origin if score @s ch.pid = #fo ch.speed.g run return 0
tag @s add ch.speed.pz
execute store result entity @s Motion[0] double 0.00012 run data get entity @s Motion[0] 1000
execute store result entity @s Motion[1] double 0.00012 run data get entity @s Motion[1] 1000
execute store result entity @s Motion[2] double 0.00012 run data get entity @s Motion[2] 1000
data modify entity @s NoGravity set value 1b
particle minecraft:end_rod ~ ~ ~ 0.1 0.1 0.1 0.01 4
playsound minecraft:block.amethyst_block.hit player @a ~ ~ ~ 0.6 1.6
