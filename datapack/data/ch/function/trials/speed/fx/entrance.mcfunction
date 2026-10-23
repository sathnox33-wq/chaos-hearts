# Vael arrives in a spiral of gold and cyan light.
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:16113986,s0:8.0,s1:0.5,t:20,life:22,spin:170,dy:0.0}
function ch:api/fx/pillar {model:"beam",color:16771466,w:1.6,h:20.0,t:4,life:16}
function ch:api/fx/pillar {model:"beam",color:2741234,w:3.0,h:14.0,t:6,life:18}
execute positioned ~ ~1.5 ~ run function ch:api/fx/orb {color:16777215,s:4.0,t:3,life:8}
particle minecraft:dust_color_transition{from_color:[0.96,0.88,0.26],to_color:[0.16,0.83,0.95],scale:1.3} ~ ~2 ~ 1 2 1 0 120
particle minecraft:end_rod ~ ~2 ~ 1 2 1 0.2 60
playsound minecraft:item.trident.riptide_3 master @a[distance=..80] ~ ~ ~ 2 1.4
playsound chaoshearts:speed_dash master @a[distance=..80] ~ ~ ~ 2 0.8
