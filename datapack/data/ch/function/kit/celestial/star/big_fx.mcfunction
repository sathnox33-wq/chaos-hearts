# A full star (not a small one): a vertical halo of light, a pillar and a heavier boom.
execute positioned ~ ~1.2 ~ rotated 0 90 run function ch:api/fx/sprite {model:"ring",color:16765803,s0:0.5,s1:4.0,t:5,life:9,spin:120,dy:0.0}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.8,h:9.0,t:3,life:8}
particle minecraft:firework ~ ~1 ~ 0.4 0.6 0.4 0.3 20
playsound minecraft:entity.firework_rocket.large_blast player @a ~ ~ ~ 1.2 0.8
function ch:api/fx/shake {s:2,t:6,r:9}
