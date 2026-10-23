# Stores the pending Celestial move on its later marker: v1 damage, v2 radius, v3 small, v4 comet, v5 counts, v6 nova.
tag @s add ch.celestial.lset
tp @s ~ ~ ~ ~ 0
scoreboard players operation @s ch.v1 = #ce_d ch.tmp
scoreboard players operation @s ch.v2 = #ce_r ch.tmp
scoreboard players operation @s ch.v3 = #ce_sm ch.tmp
scoreboard players operation @s ch.v4 = #ce_co ch.tmp
scoreboard players operation @s ch.v5 = #ce_as ch.tmp
scoreboard players operation @s ch.v6 = #ce_nv ch.tmp
