# Downburst: a crushing column of wind slams down around you. Airborne enemies are spiked, grounded ones pinned.
execute positioned ~ ~7 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:10.0,s1:2.0,t:4,life:5,spin:170,dy:-6.5}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:15267583,s0:1.0,s1:9.0,t:3,life:30,spin:20,dy:0.0}
function ch:api/fx/wave {color:5220607,r:5.0,t:5}
particle minecraft:cloud ~ ~3 ~ 2 2 2 0.4 60
particle minecraft:gust_emitter_small ~ ~0.5 ~ 1 0 1 0 4
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.4 0.8
playsound chaoshearts:storm_gale player @a ~ ~ ~ 1.2 0.6
scoreboard players set #pushed ch.storm.g 0
scoreboard players set #d ch.storm.g 40
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5] at @s run function ch:kit/storm/gale/down_one
execute if score #pushed ch.storm.g matches 4.. run function ch:api/feat {h:"storm",n:2}
function ch:api/fx/screen {o:"storm",color:"#E8F6FF",in:0,stay:2,out:8}
function ch:api/fx/shake {s:3,t:8,r:8}
title @s subtitle {text:"Downburst",color:"#E8F6FF",italic:true}
return 1
