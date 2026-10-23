# Pinwheel: a spinning disc of fire at your feet.
$function ch:api/fx/sprite {model:"swirl",color:$(c),s0:0.5,s1:7.0,t:10,life:14,spin:170,dy:0.6}
$function ch:api/fx/sprite {model:"ring",color:$(c3),s0:0.5,s1:5.0,t:6,life:10,spin:-170,dy:0.0}
$particle $(fl) ~ ~0.8 ~ 1 0.2 1 0.1 30
playsound chaoshearts:infernal_burst player @a ~ ~ ~ 1 1.2
