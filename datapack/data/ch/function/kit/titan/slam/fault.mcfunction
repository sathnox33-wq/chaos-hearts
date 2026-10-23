# Level Ground Slam: a fault line tears forward one block a tick (Long Fault, Tectonic and Aftershock apply).
scoreboard players set #ti_len ch.tmp 8
execute if score @s ch.b1 matches 2.. run scoreboard players set #ti_len ch.tmp 11
execute if score #ti_cat ch.tmp matches 1 run scoreboard players operation #ti_len ch.tmp *= #3 ch.titan.k
execute if score #ti_cat ch.tmp matches 1 run scoreboard players operation #ti_len ch.tmp /= #2 ch.g
execute if score @s ch.b1 matches 3.. run function ch:kit/titan/slam/after_set
function ch:kit/titan/slam/origin_fx
execute rotated ~ 0 run function ch:kit/titan/slam/walker
execute if score @s ch.b1 matches 5.. run function ch:kit/titan/slam/tectonic
return 1
