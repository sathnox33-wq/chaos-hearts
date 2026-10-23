# The Supernova charge, every tick.
tag @a remove ch.caster
tag @s add ch.caster
function ch:kit/infernal/pal
scoreboard players remove @s ch.infernal.nova 1
execute if score @s ch.infernal.nova matches ..0 run function ch:kit/infernal/avatar/nova_boom with storage ch:tmp ki
execute if score @s ch.infernal.nova matches 1.. run function ch:kit/infernal/avatar/nova_fx with storage ch:tmp ki
tag @s remove ch.caster
