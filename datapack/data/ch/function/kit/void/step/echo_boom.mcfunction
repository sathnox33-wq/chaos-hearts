# Later: the echo bursts - 7 damage and Darkness within 3.5 blocks, everything thrown back.
scoreboard players operation #ver ch.tmp = @s ch.v1
scoreboard players set #vd ch.tmp 70
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.5,limit=10] run function ch:kit/void/step/echo_hit
playsound chaoshearts:void_collapse player @a ~ ~ ~ 1.2 1.7
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.8 1.4
particle minecraft:explosion ~ ~1 ~ 0.4 0.4 0.4 0 3
particle minecraft:reverse_portal ~ ~1 ~ 0.2 0.5 0.2 0.5 70
execute positioned ~ ~1 ~ run function ch:api/fx/sprite {model:"star",color:15259903,s0:0.4,s1:3.5,t:2,life:5,spin:120,dy:0.0}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:9059583,s:4.0,t:3,life:6}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:13864191,r:4.5,t:5}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:5}
function ch:api/fx/shake {s:2,t:6,r:10}
