# A blood bolt's warning circle and the bolt coming down out of the moon.
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16723263,s0:4.4,s1:4.4,t:2,life:26,spin:90,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"disc",color:10357535,s0:0.5,s1:4.4,t:25,life:26,spin:0,dy:0.0}
execute positioned ~ ~18 ~ rotated 0 0 run function ch:api/fx/sprite3 {model:"spike",color:16723263,a:"[0.6,1.6,0.6]",b:"[0.6,1.6,0.6]",t:2,life:25,spin:0}
playsound chaoshearts:trial_telegraph master @a[distance=..90] ~ ~ ~ 1 1.5
