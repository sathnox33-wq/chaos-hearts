# Phase 2 (170-tick cycle): 7 meteors, double flame waves, charges.
scoreboard players operation #ib ch.tmp = @s ch.infernal.bt
scoreboard players set #i_k ch.tmp 170
scoreboard players operation #ib ch.tmp %= #i_k ch.tmp
execute if score #ib ch.tmp matches 20 run function ch:trials/infernal/meteors {n:7}
execute if score #ib ch.tmp matches 80 run function ch:trials/infernal/flamewave
execute if score #ib ch.tmp matches 102 run function ch:trials/infernal/flamewave
execute if score #ib ch.tmp matches 140 run function ch:trials/infernal/charge
