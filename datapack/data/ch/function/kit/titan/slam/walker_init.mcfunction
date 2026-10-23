# A fault line walker: life = blocks left, v1 damage, v2 hit id, v3 big slabs, v4 step, v5 cataclysm.
tag @s add ch.noability
tag @s add ch.titan.fault
tp @s ~ ~ ~ ~ 0
scoreboard players operation @s ch.life = #ti_len ch.tmp
scoreboard players operation @s ch.v1 = #ti_d ch.tmp
scoreboard players operation @s ch.v2 = #ti_cid ch.tmp
scoreboard players operation @s ch.v3 = #ti_big ch.tmp
scoreboard players operation @s ch.v5 = #ti_cat ch.tmp
scoreboard players set @s ch.v4 0
scoreboard players operation @s ch.owner = #ti_pid ch.tmp
