# Later: the hole collapses - everything within 3.2 blocks is sucked in, crushed for 6 and blinded by the dark.
scoreboard players operation #ver ch.tmp = @s ch.v1
scoreboard players set #vd ch.tmp 60
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.2,limit=10] run function ch:kit/void/step/hole_hit
playsound chaoshearts:void_collapse player @a ~ ~ ~ 1 1.5
playsound minecraft:entity.warden.sonic_boom player @a ~ ~ ~ 0.5 1.8
particle minecraft:reverse_portal ~ ~0.5 ~ 0.3 0.3 0.3 0.6 80
particle minecraft:sonic_boom ~ ~0.8 ~ 0 0 0 0 1
particle minecraft:squid_ink ~ ~0.5 ~ 0.5 0.4 0.5 0.15 30
execute positioned ~ ~0.6 ~ run function ch:api/fx/orb {color:655380,s:2.4,t:3,life:6}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:9059583,r:4.0,t:5}
function ch:api/fx/shake {s:2,t:6,r:10}
