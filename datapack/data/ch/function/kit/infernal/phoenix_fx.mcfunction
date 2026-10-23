# Phoenix visuals.
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
particle minecraft:totem_of_undying ~ ~1 ~ 0.5 1 0.5 0.6 80
$particle $(fl) ~ ~1 ~ 1.5 1.5 1.5 0.2 140
particle minecraft:dust{color:[1.0,0.82,0.25],scale:2.5} ~ ~1 ~ 2 2 2 0 80
$function ch:api/fx/orb {color:$(c3),s:7.0,t:4,life:10}
$execute rotated 0 0 run function ch:api/fx/wave {color:$(c),r:7.0,t:7}
$function ch:api/fx/pillar {model:"beam",color:$(c3),w:2.0,h:18.0,t:4,life:16}
$execute rotated ~ 0 positioned ^0.5 ^1.3 ^-0.3 rotated ~70 -35 run function ch:api/fx/sprite3 {model:"feather",color:$(c3),a:"[0.3,0.3,0.3]",b:"[2.6,2.6,5.0]",t:5,life:20,spin:10}
$execute rotated ~ 0 positioned ^-0.5 ^1.3 ^-0.3 rotated ~-70 -35 run function ch:api/fx/sprite3 {model:"feather",color:$(c3),a:"[0.3,0.3,0.3]",b:"[2.6,2.6,5.0]",t:5,life:20,spin:10}
$execute rotated ~ 0 positioned ^0.6 ^1.6 ^-0.2 rotated ~100 -15 run function ch:api/fx/sprite3 {model:"feather",color:$(c),a:"[0.3,0.3,0.3]",b:"[2.0,2.0,4.0]",t:6,life:20,spin:10}
$execute rotated ~ 0 positioned ^-0.6 ^1.6 ^-0.2 rotated ~-100 -15 run function ch:api/fx/sprite3 {model:"feather",color:$(c),a:"[0.3,0.3,0.3]",b:"[2.0,2.0,4.0]",t:6,life:20,spin:10}
function ch:api/fx/light {t:10}
function ch:api/fx/shake {s:3,t:14,r:16}
playsound chaoshearts:infernal_phoenix player @a ~ ~ ~ 2 1
playsound minecraft:item.totem.use player @a ~ ~ ~ 1 0.8
playsound minecraft:entity.blaze.death player @a ~ ~ ~ 1 0.5
