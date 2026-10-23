# Two enemies inside the eye are marked for a bolt.
function ch:api/tag_owner
scoreboard players set #v1 ch.storm.g 55
scoreboard players set #v2 ch.storm.g 1
scoreboard players set #v3 ch.storm.g 0
scoreboard players set #v4 ch.storm.g 0
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r),sort=random,limit=2] at @s run function ch:kit/storm/tempest/mark
tag @a remove ch.caster
