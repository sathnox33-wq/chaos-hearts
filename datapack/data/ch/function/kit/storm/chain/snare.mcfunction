# Arc Snare: tethers up to 6 enemies within 6 blocks to you for 3 seconds.
scoreboard players set #n ch.storm.g 0
scoreboard players operation #pid ch.storm.g = @s ch.pid
scoreboard players set #d ch.storm.g 25
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6,limit=6,sort=nearest] at @s run function ch:kit/storm/chain/snare_one
execute if score #n ch.storm.g matches 0 run return fail
execute if score #n ch.storm.g matches 5.. run function ch:api/feat {h:"storm",n:1}
function ch:api/fx/wave {color:10189823,r:6.0,t:6}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:10189823,s0:1.0,s1:4.0,t:5,life:12,spin:170,dy:0.0}
playsound minecraft:block.conduit.attack.target player @a ~ ~ ~ 1.2 1.2
playsound chaoshearts:storm_chain player @a ~ ~ ~ 1 1.4
title @s subtitle {text:"Arc Snare - they cannot run",color:"#9B7BFF",italic:true}
return 1
