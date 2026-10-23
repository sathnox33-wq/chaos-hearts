# Gale Burst. Level: blast everyone away and ride the updraft (Cyclone: lift, spin, fling).
# Up: Updraft Column, a telegraphed geyser of wind at your aim hurls them skyward. Down: Downburst, slam them into the ground.
execute if score #var ch.tmp matches 1 run return run function ch:kit/storm/gale/column_start
execute if score #var ch.tmp matches 2 run return run function ch:kit/storm/gale/down
scoreboard players set #pushed ch.storm.g 0
particle minecraft:gust_emitter_large ~ ~0.5 ~ 0 0 0 0 1
function ch:api/fx/wave {color:15267583,r:6.0,t:6}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:16777215,s0:1.0,s1:13.0,t:5,life:8,spin:170,dy:0.0}
execute positioned ~ ~0.4 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:5220607,s0:1.0,s1:12.0,t:7,life:10,spin:-170,dy:1.0}
function ch:api/fx/ring {p:"minecraft:cloud",r:3}
execute positioned ~ ~1 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[0.91,0.96,1.0],scale:1.0}",r:5}
playsound chaoshearts:storm_gale player @a ~ ~ ~ 1.3 1
playsound minecraft:entity.wind_charge.wind_burst player @a ~ ~ ~ 1.2 0.7
playsound minecraft:entity.breeze.shoot player @a ~ ~ ~ 1 0.8
execute if score @s ch.b2 matches 5.. run function ch:kit/storm/gale/cyclone_start
execute unless score @s ch.b2 matches 5.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6] run function ch:kit/storm/gale/blow
execute if score #pushed ch.storm.g matches 4.. run function ch:api/feat {h:"storm",n:2}
function ch:kit/storm/gale/lift
execute if score @s ch.b2 matches 3.. run scoreboard players set @s ch.storm.ww 60
function ch:api/fx/screen {o:"storm",color:"#E8F6FF",in:0,stay:2,out:8}
function ch:api/fx/shake {s:2,t:6,r:8}
return 1
