# Avalanche (phase 3): a boulder falls near the challenger every 1.25 s.
scoreboard players set @s ch.titan.tb1 25
execute store result storage ch:tmp tr.x int 1 run random value -6..6
execute store result storage ch:tmp tr.z int 1 run random value -6..6
execute at @a[tag=ch.challenger,limit=1] run function ch:trials/titan/aval_at with storage ch:tmp tr
