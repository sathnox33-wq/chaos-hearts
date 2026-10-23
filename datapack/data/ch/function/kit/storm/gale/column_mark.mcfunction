# The telegraph: wind gathers in a spiral on the marked ground.
function ch:api/later {t:10,then:"ch:kit/storm/gale/column"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/storm/fn/cfg
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:15267583,s0:5.0,s1:1.5,t:10,life:11,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:5.4,s1:5.0,t:10,life:11,spin:-90,dy:0.0}
particle minecraft:cloud ~ ~0.2 ~ 1.5 0.05 1.5 0.02 30
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 0.8 1.8
