# As a new cloud marker.
tag @s remove ch.corruption.cnew
execute if entity @a[tag=ch.caster,limit=1] run function ch:api/own
execute unless entity @a[tag=ch.caster,limit=1] run scoreboard players set @s ch.owner 0
function ch:api/new_eid
scoreboard players operation @s ch.v2 = #crad ch.tmp
scoreboard players operation @s ch.life = #clife ch.tmp
scoreboard players operation @s ch.v4 = #camp ch.tmp
scoreboard players operation @s ch.v5 = #cwit ch.tmp
scoreboard players set @s ch.v3 0
scoreboard players set @s ch.t 0
