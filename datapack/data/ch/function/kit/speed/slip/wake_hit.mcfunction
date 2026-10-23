# The wake bites: enemies inside it are slowed (Slipstream) or burned (Afterburner).
function ch:api/tag_owner
execute if score @s ch.v1 matches 0 if score @s ch.v2 matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.3] at @s run function ch:kit/speed/slip/slow
execute if score @s ch.v1 matches 0 if score @s ch.v2 matches 1 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.8] at @s run function ch:kit/speed/slip/slow
execute if score @s ch.v1 matches 1 if score @s ch.v2 matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.3] at @s run function ch:kit/speed/slip/burn
execute if score @s ch.v1 matches 1 if score @s ch.v2 matches 1 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.8] at @s run function ch:kit/speed/slip/burn
tag @a remove ch.caster
