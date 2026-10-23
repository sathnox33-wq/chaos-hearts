# As a singularity every tick.
scoreboard players add @s ch.t 1
scoreboard players remove @s ch.life 1
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players operation #sid ch.tmp = @s ch.eid
scoreboard players operation #ver ch.tmp = @s ch.v6
tag @s add ch.void.scur
execute if score @s ch.v1 matches 1 run function ch:kit/void/sing/follow
execute at @s run function ch:kit/void/sing/tick2
tag @s remove ch.void.scur
tag @a remove ch.caster
