# Every 5 ticks: the halo turns 45 degrees, and the beast smoulders (more as he weakens).
scoreboard players operation #q ch.tmp = @s ch.v1
scoreboard players operation #q ch.tmp /= #5 ch.g
scoreboard players operation #q ch.tmp %= #8 ch.g
execute on passengers if entity @s[tag=ch.rage.halo] run function ch:trials/rage/halo_spin
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.6} ~ ~2.5 ~ 1 0.8 1 0 4
particle minecraft:flame ~ ~3 ~ 0.4 0.3 0.4 0.02 2
execute if score @s ch.v6 matches 3 run particle minecraft:soul_fire_flame ~ ~2 ~ 1 1 1 0.03 6
execute if score @s ch.v6 matches 3 run particle minecraft:dust{color:[0.07,0.0,0.0],scale:2.5} ~ ~2 ~ 1.2 1 1.2 0 6
