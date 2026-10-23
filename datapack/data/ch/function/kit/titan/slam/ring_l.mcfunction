# A delayed Epicenter ring (as its marker).
execute unless entity @a[tag=ch.caster,limit=1] run return 0
scoreboard players operation #ti_d ch.tmp = @s ch.v1
scoreboard players operation #ti_cid ch.tmp = @s ch.v2
scoreboard players operation #ti_big ch.tmp = @s ch.v3
scoreboard players operation #ti_x ch.tmp = @s ch.v4
scoreboard players operation #ti_cat ch.tmp = @s ch.v5
function ch:kit/titan/slam/ring
