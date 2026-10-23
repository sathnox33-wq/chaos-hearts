# A fireball's burst.
$particle $(fl) ~ ~ ~ 0.3 0.3 0.3 0.08 18
particle minecraft:lava ~ ~ ~ 0.2 0.2 0.2 0 3
particle minecraft:explosion ~ ~ ~ 0 0 0 0 1
$function ch:api/fx/orb {color:$(c3),s:1.6,t:3,life:6}
$execute rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:$(c),s0:0.3,s1:3.0,t:4,life:7,spin:90,dy:0.0}
$function ch:api/fx/sprite {model:"star",color:$(c),s0:0.4,s1:2.2,t:3,life:6,spin:170,dy:0.0}
function ch:api/fx/light {t:3}
playsound minecraft:item.firecharge.use player @a ~ ~ ~ 0.8 1.2
playsound chaoshearts:infernal_burst player @a ~ ~ ~ 0.5 1.4
