# The Tempest mark (on the ground).
function ch:api/later {t:10,then:"ch:kit/storm/tempest/bolt"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/storm/fn/cfg
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:15267583,s0:3.0,s1:0.6,t:10,life:11,spin:170,dy:0.0}
particle minecraft:electric_spark ~ ~2 ~ 0.3 2 0.3 0 12
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 0.5 2
