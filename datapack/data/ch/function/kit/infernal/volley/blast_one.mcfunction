# As a blast target (position = blast centre): knocked away, then burned for #i_bd.
function ch:api/push {s:0.6,y:0.45}
scoreboard players operation #i_dmg ch.tmp = #i_bd ch.tmp
execute at @s run function ch:kit/infernal/sear
