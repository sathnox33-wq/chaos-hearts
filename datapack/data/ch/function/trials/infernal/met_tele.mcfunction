# Meteor telegraph: a burning circle; the meteor is released 20 ticks later.
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"hex",color:16742938,s0:0.5,s1:5.6,t:8,life:30,spin:170,dy:0.0}
execute rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"ring_soft",color:14692378,s0:5.6,s1:1.0,t:28,life:30,spin:90,dy:0.0}
particle minecraft:flame ~ ~0.2 ~ 1.2 0 1.2 0.01 12
playsound chaoshearts:trial_telegraph master @a[distance=..40] ~ ~ ~ 1 1
function ch:api/later {t:20,then:"ch:trials/infernal/met_drop"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
