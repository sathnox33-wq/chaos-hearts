# Quake Step: each footstep is a small quake (1.5 damage, 3 blocks).
function ch:api/fx/wave {color:8025194,r:3,t:4}
function ch:kit/titan/fx/debris
playsound minecraft:entity.ravager.step player @a ~ ~ ~ 1.4 0.5
playsound minecraft:item.mace.smash_ground player @a ~ ~ ~ 0.8 0.6
function ch:api/fx/shake {s:2,t:4,r:7}
scoreboard players set #ti_d ch.tmp 15
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3] run function ch:kit/titan/col/blow_hit
