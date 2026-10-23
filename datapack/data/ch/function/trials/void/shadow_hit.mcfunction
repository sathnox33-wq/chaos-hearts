# Later: the shadow blast - 9 damage within 3 blocks of where the Sovereign appeared.
execute as @a[tag=ch.challenger,distance=..3] run function ch:trials/void/strike {d:90}
execute as @a[tag=ch.challenger,distance=..3] run function ch:api/pull {s:0.4}
particle minecraft:explosion ~ ~1 ~ 0.5 0.4 0.5 0 3
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.4 0.3 0.6 80
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:655380,s:5.0,t:3,life:6}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:9059583,r:4.0,t:5}
playsound chaoshearts:void_collapse hostile @a ~ ~ ~ 1.5 1.5
function ch:api/fx/shake {s:2,t:6,r:10}
