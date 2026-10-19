scoreboard players remove @s ch.life 1
data modify storage ch:tmp p set from entity @s item.components."minecraft:custom_data"
execute if score @s ch.life matches ..0 run return run function ch:api/proj_end with storage ch:tmp p
tag @a remove ch.caster
function ch:api/tag_owner
tag @a[tag=ch.caster] add ch.powner
scoreboard players operation #steps ch.tmp = @s ch.v1
function ch:api/proj_step with storage ch:tmp p
execute if entity @s[tag=!ch.pdead] at @s run function ch:api/proj_run_step with storage ch:tmp p
tag @a remove ch.powner
tag @a remove ch.caster
