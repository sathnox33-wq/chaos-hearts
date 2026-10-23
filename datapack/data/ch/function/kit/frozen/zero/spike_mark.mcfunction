# A spike is coming: a frost circle under the target; it erupts 10 ticks later.
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"ring_soft",color:3108776,s0:3.2,s1:2.4,t:10,life:11,spin:120,dy:0.0}
particle minecraft:dust{color:[0.18,0.44,0.66],scale:1.4} ~ ~0.1 ~ 0.8 0 0.8 0 14
playsound minecraft:block.glass.hit player @a ~ ~ ~ 0.8 0.6
function ch:api/later {t:10,then:"ch:kit/frozen/zero/spike"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
