# Phase 2 (190-tick cycle): triple spike lines, blizzards and the ice prison.
scoreboard players operation #fb ch.tmp = @s ch.frozen.bt
scoreboard players set #f_k ch.tmp 190
scoreboard players operation #fb ch.tmp %= #f_k ch.tmp
execute if score #fb ch.tmp matches 20 run function ch:trials/frozen/spikes {n:3}
execute if score #fb ch.tmp matches 60 run function ch:trials/frozen/blizzard_start
execute if score #fb ch.tmp matches 120 run function ch:trials/frozen/prison
execute if score #fb ch.tmp matches 160 run function ch:trials/frozen/spikes {n:3}
