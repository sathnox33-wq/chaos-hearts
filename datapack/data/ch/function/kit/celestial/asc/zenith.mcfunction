# Zenith: a full star falls wherever the Celestial looks (6 damage, radius 2.5).
function ch:kit/celestial/asc/setstar
scoreboard players set #ce_d ch.tmp 60
scoreboard players set #ce_r ch.tmp 25
scoreboard players set #ce_sm ch.tmp 0
tag @s add ch.caster
function ch:api/ray {range:48}
execute if score #rayhit ch.tmp matches 1 at @e[tag=ch.target,limit=1] run function ch:kit/celestial/star/call
execute if score #rayhit ch.tmp matches 0 at @e[type=marker,tag=ch.rayend,limit=1] run function ch:kit/celestial/star/drop
tag @e[tag=ch.target] remove ch.target
tag @s remove ch.caster
