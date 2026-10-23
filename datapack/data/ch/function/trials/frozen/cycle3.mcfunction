# Phase 3 (150-tick cycle, endless blizzard): spike lines, prisons, shard barrages and a frost nova if you come close.
scoreboard players operation #fb ch.tmp = @s ch.frozen.bt
scoreboard players set #f_k ch.tmp 150
scoreboard players operation #fb ch.tmp %= #f_k ch.tmp
execute if score #fb ch.tmp matches 15 run function ch:trials/frozen/spikes {n:3}
execute if score #fb ch.tmp matches 75 run function ch:trials/frozen/prison
execute if score #fb ch.tmp matches 45 run function ch:trials/frozen/barrage
execute if score #fb ch.tmp matches 120 run function ch:trials/frozen/barrage
scoreboard players operation #fb ch.tmp = @s ch.frozen.bt
scoreboard players set #f_k ch.tmp 40
scoreboard players operation #fb ch.tmp %= #f_k ch.tmp
execute if score #fb ch.tmp matches 0 if entity @a[tag=ch.challenger,distance=..6,limit=1] run function ch:trials/frozen/nova
