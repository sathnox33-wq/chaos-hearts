# Corruption became active: rot blooms at your feet.
playsound chaoshearts:corruption_spread player @a ~ ~ ~ 0.6 1.2
particle minecraft:dust{color:[0.482,0.82,0.227],scale:1.4} ~ ~0.3 ~ 0.6 0.1 0.6 0 30
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:8114490,s0:0.4,s1:3.0,t:8,life:12,spin:90,dy:0.0}
