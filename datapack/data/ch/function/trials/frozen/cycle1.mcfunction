# Phase 1 (220-tick cycle): spike lines and a blizzard.
scoreboard players operation #fb ch.tmp = @s ch.frozen.bt
scoreboard players set #f_k ch.tmp 220
scoreboard players operation #fb ch.tmp %= #f_k ch.tmp
execute if score #fb ch.tmp matches 30 run function ch:trials/frozen/spikes {n:1}
execute if score #fb ch.tmp matches 80 run function ch:trials/frozen/blizzard_start
execute if score #fb ch.tmp matches 170 run function ch:trials/frozen/spikes {n:1}
