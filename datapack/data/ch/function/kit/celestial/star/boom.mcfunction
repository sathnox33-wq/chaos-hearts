# Impact layers for a star of radius $(r).
$execute positioned ~ ~0.5 ~ run function ch:api/fx/orb {color:16777215,s:$(d),t:2,life:5}
$function ch:api/fx/wave {color:16765803,r:$(r),t:6}
execute positioned ~ ~0.6 ~ rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.5,s1:3.0,t:4,life:8,spin:170,dy:0.6}
particle minecraft:firework ~ ~0.5 ~ 0.2 0.2 0.2 0.25 24
particle minecraft:end_rod ~ ~0.5 ~ 0.3 0.3 0.3 0.15 16
particle minecraft:glow ~ ~0.3 ~ 0.8 0.2 0.8 0 8
playsound chaoshearts:celestial_starfall player @a ~ ~ ~ 1 1.3
playsound minecraft:block.amethyst_cluster.break player @a ~ ~ ~ 1.2 1.4
playsound minecraft:entity.firework_rocket.blast player @a ~ ~ ~ 1 1.2
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:5}
function ch:api/fx/shake {s:1,t:4,r:6}
