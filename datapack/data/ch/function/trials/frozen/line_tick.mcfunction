# Every 3 ticks the runner moves 2.2 blocks and marks a spike.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
scoreboard players operation #fb ch.tmp = @s ch.life
scoreboard players operation #fb ch.tmp %= #4 ch.g

execute unless score #fb ch.tmp matches 0 run return 0
tp @s ^ ^ ^2.4
execute at @s run function ch:trials/frozen/spike_mark
