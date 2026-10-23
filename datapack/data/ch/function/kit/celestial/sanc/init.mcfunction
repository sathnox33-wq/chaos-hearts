# The sanctuary marker: life, radius (tenths), mode, owner.
tag @s add ch.noability
tag @s add ch.celestial.sanc
scoreboard players operation @s ch.life = #ce_l ch.tmp
scoreboard players operation @s ch.v1 = #ce_r ch.tmp
scoreboard players operation @s ch.v2 = #var ch.tmp
scoreboard players set @s ch.v4 0
scoreboard players operation @s ch.owner = #ce_pid ch.tmp
