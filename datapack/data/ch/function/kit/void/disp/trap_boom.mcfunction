# Later: the rift trap collapses.
scoreboard players operation #ver ch.tmp = @s ch.v1
scoreboard players set #vd ch.tmp 90
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.6,limit=8] run function ch:kit/void/step/hole_hit
playsound chaoshearts:void_collapse player @a ~ ~ ~ 1.2 1.2
playsound minecraft:entity.warden.sonic_boom player @a ~ ~ ~ 0.6 1.5
particle minecraft:sonic_boom ~ ~0.8 ~ 0 0 0 0 1
particle minecraft:reverse_portal ~ ~0.5 ~ 0.3 0.3 0.3 0.6 70
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:655380,s:3.0,t:3,life:6}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:9059583,r:3.5,t:5}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:9059583,w:2.6,h:6.0,t:3,life:8}
function ch:api/fx/shake {s:2,t:6,r:8}
