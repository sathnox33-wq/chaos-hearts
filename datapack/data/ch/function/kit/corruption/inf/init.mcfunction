# As a new infection marker.
tag @s remove ch.corruption.inew
execute if entity @a[tag=ch.caster,limit=1] run function ch:api/own
function ch:api/new_eid
scoreboard players operation #chid ch.tmp = @s ch.eid
scoreboard players operation @s ch.v1 = #cfuse ch.tmp
scoreboard players operation @s ch.v2 = #cgen ch.tmp
scoreboard players operation @s ch.v3 = #crad ch.tmp
scoreboard players operation @s ch.v4 = #cdmg ch.tmp
scoreboard players operation @s ch.v6 = #cnec ch.tmp
scoreboard players set @s ch.t 0
execute if score #cfc ch.tmp matches 1 run tag @s add ch.corruption.fc
execute if score #cfb ch.tmp matches 1 run tag @s add ch.corruption.fb
execute if score #cfa ch.tmp matches 1 run tag @s add ch.corruption.fa
execute if score #cfl ch.tmp matches 1 run tag @s add ch.corruption.fl
execute if score #cfs ch.tmp matches 1 run tag @s add ch.corruption.fs
