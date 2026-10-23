# Supercell wind-up: the funnel tightens.
particle minecraft:electric_spark ~ ~5 ~ 3 4 3 0.3 50
execute positioned ~ ~0.15 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:18.0,s1:9.0,t:10,life:11,spin:170,dy:0.0}
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 1.2 0.8
function ch:api/fx/shake {s:1,t:10,r:14}
