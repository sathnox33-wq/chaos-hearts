# A spike's mark.
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"ring_soft",color:3108776,s0:3.6,s1:2.4,t:14,life:15,spin:120,dy:0.0}
particle minecraft:dust{color:[0.61,0.91,1.0],scale:1.4} ~ ~0.15 ~ 0.8 0 0.8 0 12
playsound minecraft:block.glass.hit master @a[distance=..40] ~ ~ ~ 0.8 0.6
function ch:api/later {t:14,then:"ch:trials/frozen/spike"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
