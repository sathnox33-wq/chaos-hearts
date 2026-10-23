# The prison's telegraph.
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"hex",color:3108776,s0:4.0,s1:3.2,t:28,life:30,spin:170,dy:0.0}
execute rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"ring",color:10217471,s0:0.5,s1:3.4,t:28,life:30,spin:-170,dy:0.0}
function ch:api/fx/pillar {model:"beam",color:10217471,w:3.2,h:3.0,t:28,life:30}
playsound chaoshearts:trial_telegraph master @a[distance=..40] ~ ~ ~ 1 0.8
function ch:api/later {t:30,then:"ch:trials/frozen/prison_close"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
