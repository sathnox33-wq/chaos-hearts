# As the caster: traces from the eyes up to $(range) blocks. The first entity in the way is tagged ch.target
# (#rayhit ch.tmp = 1) and a marker tagged ch.rayend is left where the ray stopped (removed at the end of the tick).
$scoreboard players set #rs ch.tmp $(range)
scoreboard players operation #rs ch.tmp *= #2 ch.g
scoreboard players set #rayhit ch.tmp 0
tag @s add ch.rself
execute anchored eyes positioned ^ ^ ^0.5 run function ch:api/ray_step
tag @s remove ch.rself
