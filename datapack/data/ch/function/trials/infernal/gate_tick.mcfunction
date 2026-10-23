# A hellgate: flames, and it burns a challenger standing in it.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
particle minecraft:flame ~ ~0.3 ~ 1 0.1 1 0.02 3
scoreboard players operation #ib ch.tmp = @s ch.life
scoreboard players operation #ib ch.tmp %= #10 ch.g
execute if score #ib ch.tmp matches 0 run particle minecraft:lava ~ ~0.3 ~ 0.8 0 0.8 0 2
execute if score #ib ch.tmp matches 0 as @a[tag=ch.challenger,distance=..2.8] at @s run function ch:trials/infernal/hit {d:25}
execute if score #ib ch.tmp matches 5 run function ch:api/fx/sprite3 {model:"flame",color:16742938,a:"[2.0,0.3,2.0]",b:"[2.6,2.4,2.6]",t:4,life:9,spin:90}
