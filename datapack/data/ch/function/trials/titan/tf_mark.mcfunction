# A warning mark on the fault's path.
execute positioned ~ ~0.05 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.4,s1:2.2,t:4,life:22,spin:0,dy:0.0}
particle minecraft:dust{color:[1.0,0.478,0.165],scale:1.8} ~ ~0.2 ~ 0.6 0 0.6 0 8
playsound chaoshearts:trial_telegraph master @a ~ ~ ~ 0.5 1.2
