# As a target, caster tagged: Void ability damage of #vd tenths; Erasure (#ver 1) adds 20% against targets in Darkness.
scoreboard players operation #vdx ch.tmp = #vd ch.tmp
execute if score #ver ch.tmp matches 1 if entity @s[nbt={active_effects:[{id:"minecraft:darkness"}]}] run function ch:kit/void/erase
execute store result storage ch:void h.d int 1 run scoreboard players get #vdx ch.tmp
function ch:api/hit with storage ch:void h
