# Re-applies the max health bonus only when its size changed (removing it clamps health).
scoreboard players operation @s ch.titan.hp = #ti_hp ch.tmp
attribute @s minecraft:max_health modifier remove ch:titan_health
execute store result storage ch:tmp ti.hp int 1 run scoreboard players get #ti_hp ch.tmp
function ch:kit/titan/passive/health2 with storage ch:tmp ti
