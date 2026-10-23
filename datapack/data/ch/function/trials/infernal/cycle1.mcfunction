# Phase 1 (200-tick cycle): meteors, a flame wave, a cinder charge.
scoreboard players operation #ib ch.tmp = @s ch.infernal.bt
scoreboard players set #i_k ch.tmp 200
scoreboard players operation #ib ch.tmp %= #i_k ch.tmp
execute if score #ib ch.tmp matches 30 run function ch:trials/infernal/meteors {n:5}
execute if score #ib ch.tmp matches 100 run function ch:trials/infernal/flamewave
execute if score #ib ch.tmp matches 160 run function ch:trials/infernal/charge
