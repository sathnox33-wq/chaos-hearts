# Stormcall: you charge for 8 ticks, the sky answers on you, and the bolt bursts outward.
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:5220607,s0:0.5,s1:4.5,t:8,life:9,spin:170,dy:0.0}
execute positioned ~ ~0.12 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:15267583,s0:5.0,s1:0.8,t:8,life:9,spin:-170,dy:0.0}
particle minecraft:electric_spark ~ ~1 ~ 0.5 1 0.5 0.1 30
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 1 1.4
playsound minecraft:block.respawn_anchor.charge player @a ~ ~ ~ 1 1.6
effect give @s minecraft:resistance 1 1 true
function ch:api/later {t:8,then:"ch:kit/storm/ls/nova"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/storm/fn/cfg
title @s subtitle {text:"Stormcall",color:"#4FA8FF",italic:true}
return 1
