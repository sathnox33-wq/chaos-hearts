# Ground Slam. Level: a fault line tears forward. Up: Skybreaker, leap and crash down on a marked spot.
# Down: Epicenter, the ground ripples out in three rings. A full Tremor meter turns any of them into a Cataclysm.
scoreboard players operation #ti_pid ch.tmp = @s ch.pid
scoreboard players set @s ch.titan.sc 0
scoreboard players set #ti_cat ch.tmp 0
execute if score @s ch.titan.trem matches 100.. run function ch:kit/titan/slam/cataclysm
scoreboard players add #ti_cid ch.titan.cid 1
scoreboard players operation #ti_cid ch.tmp = #ti_cid ch.titan.cid
scoreboard players set #ti_d ch.tmp 60
execute if score @s ch.b1 matches 1.. run scoreboard players set #ti_d ch.tmp 75
execute if score #ti_cat ch.tmp matches 1 run scoreboard players operation #ti_d ch.tmp *= #3 ch.titan.k
execute if score #ti_cat ch.tmp matches 1 run scoreboard players operation #ti_d ch.tmp /= #2 ch.g
execute if score @s ch.titan.col matches 1.. run scoreboard players operation #ti_d ch.tmp *= #6 ch.titan.k
execute if score @s ch.titan.col matches 1.. run scoreboard players operation #ti_d ch.tmp /= #5 ch.titan.k
scoreboard players set #ti_big ch.tmp 0
execute if score #ti_cat ch.tmp matches 1 run scoreboard players set #ti_big ch.tmp 1
execute if score @s ch.titan.col matches 1.. run scoreboard players set #ti_big ch.tmp 1
execute if score #var ch.tmp matches 1 run return run function ch:kit/titan/slam/sky
execute if score #var ch.tmp matches 2 run return run function ch:kit/titan/slam/epicenter
return run function ch:kit/titan/slam/fault
