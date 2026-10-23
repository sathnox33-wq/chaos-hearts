# The telegraph: a sigil crackles on the ground for 6 ticks before the bolt lands.
function ch:api/later {t:6,then:"ch:kit/storm/ls/strike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/storm/fn/cfg
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:5220607,s0:3.0,s1:1.2,t:6,life:7,spin:-170,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:15267583,s0:3.6,s1:0.6,t:6,life:7,spin:170,dy:0.0}
particle minecraft:electric_spark ~ ~3 ~ 0.3 3 0.3 0 30
particle minecraft:dust{color:[0.31,0.66,1.0],scale:0.7} ~ ~0.2 ~ 1.2 0.05 1.2 0 20
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 0.8 2
