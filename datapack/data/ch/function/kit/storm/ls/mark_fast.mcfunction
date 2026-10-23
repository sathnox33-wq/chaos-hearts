# A short-fused secondary strike mark.
function ch:api/later {t:3,then:"ch:kit/storm/ls/strike_plain"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/storm/fn/cfg
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:15267583,s0:2.4,s1:0.6,t:3,life:4,spin:170,dy:0.0}
