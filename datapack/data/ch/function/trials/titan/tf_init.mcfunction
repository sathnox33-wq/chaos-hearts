# Fault walker: mode $(m) (0 marks, 1 erupts), waits $(w) ticks, 11 steps of 1.8 blocks.
tag @s add ch.noability
tag @s add ch.tmob
tag @s add ch.titan.tf
tp @s ~ ~ ~ ~ 0
$scoreboard players set @s ch.v1 $(m)
$scoreboard players set @s ch.v2 $(w)
scoreboard players operation @s ch.v3 = #ti_cid ch.titan.cid
scoreboard players set @s ch.life 11
