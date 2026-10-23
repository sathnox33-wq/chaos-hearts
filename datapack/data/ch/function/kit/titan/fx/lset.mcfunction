# Stores the pending Titan move on its later marker: v1 damage, v2 hit id, v3 big, v4 extra, v5 cataclysm.
tag @s add ch.titan.lset
tp @s ~ ~ ~ ~ 0
scoreboard players operation @s ch.v1 = #ti_d ch.tmp
scoreboard players operation @s ch.v2 = #ti_cid ch.tmp
scoreboard players operation @s ch.v3 = #ti_big ch.tmp
scoreboard players operation @s ch.v4 = #ti_x ch.tmp
scoreboard players operation @s ch.v5 = #ti_cat ch.tmp
