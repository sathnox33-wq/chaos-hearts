# Tempest. Level: become the storm, bolts rain on enemies around you (Ride the Lightning: fly).
# Up: Eye of the Storm, a vortex anchored here that drags enemies in under faster bolts.
# Down: Supercell, root yourself for 1.5 seconds, then one cataclysmic strike.
execute if score #var ch.tmp matches 1 run return run function ch:kit/storm/tempest/eye_start
execute if score #var ch.tmp matches 2 run return run function ch:kit/storm/tempest/super_start
scoreboard players set @s ch.storm.temp 200
execute if score @s ch.b3 matches 1.. run scoreboard players set @s ch.storm.temp 260
scoreboard players operation @s ch.storm.tmax = @s ch.storm.temp
scoreboard players set @s ch.storm.th 0
scoreboard players set @s ch.storm.tmode 0
effect give @s minecraft:speed 13 1 true
execute positioned ~ ~0.2 ~ summon minecraft:wind_charge run data merge entity @s {Motion:[0.0,-1.0,0.0]}
function ch:kit/storm/fn/bolt
execute positioned ~ ~6 ~ rotated 0 0 run function ch:api/fx/sprite {model:"cloud",color:7241632,s0:1.0,s1:11.0,t:10,life:20,spin:170,dy:0.0}
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
playsound chaoshearts:storm_tempest player @a ~ ~ ~ 2 1
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 2 0.7
function ch:api/fx/screen {o:"storm",color:"#4FA8FF",in:1,stay:6,out:14}
title @s subtitle {text:"⛈ Tempest",color:"#4FA8FF",bold:true}
function ch:api/fx/shake {s:3,t:12,r:14}
return 1
