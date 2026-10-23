# While a slam leap is in the air: trail, a ring marking the landing spot, a forced dive, then the landing.
scoreboard players remove @s ch.titan.air 1
scoreboard players add @s ch.titan.airt 1
particle minecraft:dust{color:[0.788,0.643,0.361],scale:1.6} ~ ~0.6 ~ 0.3 0.4 0.3 0 3
particle minecraft:falling_dust{block_state:"minecraft:gravel"} ~ ~0.5 ~ 0.3 0.3 0.3 0 2
scoreboard players operation #ti_m ch.tmp = @s ch.titan.airt
scoreboard players operation #ti_m ch.tmp %= #2 ch.g
scoreboard players operation #ti_r ch.tmp = @s ch.titan.airm
scoreboard players set #ti_dd ch.tmp 25
execute if score #ti_m ch.tmp matches 0 run function ch:kit/titan/fx/findg
execute if score @s ch.titan.airt matches 10 unless predicate ch:on_ground at @s rotated ~ 90 run function ch:api/push_player
execute if score @s ch.titan.airt matches 10 run playsound minecraft:item.mace.smash_air player @a ~ ~ ~ 1 0.6
execute if score @s ch.titan.airt matches 4.. if predicate ch:on_ground run return run function ch:kit/titan/slam/land
execute if score @s ch.titan.air matches 0 run function ch:kit/titan/slam/cancel
