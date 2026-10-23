# Phase 3 (140-tick cycle): 9 meteors, waves, charges, seeking fireballs and new hellgates.
scoreboard players operation #ib ch.tmp = @s ch.infernal.bt
scoreboard players set #i_k ch.tmp 140
scoreboard players operation #ib ch.tmp %= #i_k ch.tmp
execute if score #ib ch.tmp matches 10 run function ch:trials/infernal/meteors {n:9}
execute if score #ib ch.tmp matches 60 run function ch:trials/infernal/flamewave
execute if score #ib ch.tmp matches 110 run function ch:trials/infernal/charge
execute if score #ib ch.tmp matches 5 run function ch:trials/infernal/gates
scoreboard players operation #ib ch.tmp = @s ch.infernal.bt
scoreboard players set #i_k ch.tmp 45
scoreboard players operation #ib ch.tmp %= #i_k ch.tmp
execute if score #ib ch.tmp matches 20 run function ch:trials/infernal/seeker
