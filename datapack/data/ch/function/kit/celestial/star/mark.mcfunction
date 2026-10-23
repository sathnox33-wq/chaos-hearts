# The telegraph: a spinning sigil and a ring grow on the ground of radius $(r), a faint shaft of light from above.
$execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:16765803,s0:0.4,s1:$(d),t:12,life:15,spin:150,dy:0.0}
$execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:16773808,s0:$(d),s1:0.6,t:12,life:14,spin:-90,dy:0.0}
$execute positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.827,0.42],scale:1.2}",r:$(r)}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16773808,w:0.12,h:16.0,t:10,life:13}
playsound chaoshearts:celestial_chime player @a ~ ~ ~ 0.8 1.6
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 0.5 2
