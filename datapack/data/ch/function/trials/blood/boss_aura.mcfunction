# Every 5 ticks: the crown turns and blood drips from her.
scoreboard players operation #q ch.tmp = @s ch.v1
scoreboard players operation #q ch.tmp /= #5 ch.g
scoreboard players operation #q ch.tmp %= #8 ch.g
execute on passengers if entity @s[tag=ch.blood.halo] run function ch:trials/rage/halo_spin
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~2.2 ~ 0.6 0.6 0.6 0 4
particle minecraft:dust{color:[0.62,0.04,0.12],scale:1.3} ~ ~1.5 ~ 0.7 0.8 0.7 0 4
execute if score @s ch.v6 matches 3 run particle minecraft:crimson_spore ~ ~2 ~ 1.5 1 1.5 0 10
