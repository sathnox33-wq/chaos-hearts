# Tectonic: two more fault lines split off at 30 degrees, 80% as long and as strong.
scoreboard players operation #ti_d ch.tmp *= #4 ch.g
scoreboard players operation #ti_d ch.tmp /= #5 ch.titan.k
scoreboard players operation #ti_len ch.tmp *= #4 ch.g
scoreboard players operation #ti_len ch.tmp /= #5 ch.titan.k
execute rotated ~30 0 run function ch:kit/titan/slam/walker
execute rotated ~-30 0 run function ch:kit/titan/slam/walker
