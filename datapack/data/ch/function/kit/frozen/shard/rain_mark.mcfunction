# The icicle target: a frost sigil and the danger circle.
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"hex",color:6273256,s0:0.5,s1:6.0,t:8,life:22,spin:170,dy:0.0}
execute rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"ring_soft",color:10217471,s0:6.0,s1:6.0,t:14,life:22,spin:90,dy:0.0}
particle minecraft:snowflake ~ ~6 ~ 2 0.5 2 0.01 30
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 0.8 1.5
function ch:api/later {t:14,then:"ch:kit/frozen/shard/rain_fall"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
