# Eye of the Storm: a vortex anchored where you stand, 8 seconds (Rolling Thunder 10.4).
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.eye","ch.noability","ch.storm.enew"]}
scoreboard players operation @e[type=marker,tag=ch.storm.enew,limit=1] ch.owner = @s ch.pid
scoreboard players set @e[type=marker,tag=ch.storm.enew,limit=1] ch.life 160
execute if score @s ch.b3 matches 1.. run scoreboard players set @e[type=marker,tag=ch.storm.enew,limit=1] ch.life 208
scoreboard players set @e[type=marker,tag=ch.storm.enew,limit=1] ch.v1 10
execute if score @s ch.b3 matches 2.. run scoreboard players set @e[type=marker,tag=ch.storm.enew,limit=1] ch.v1 13
scoreboard players set @s ch.storm.th 0
tag @e[type=marker,tag=ch.storm.enew] remove ch.storm.enew
function ch:kit/storm/fn/bolt
function ch:api/fx/wave {color:5220607,r:10.0,t:10}
playsound chaoshearts:storm_tempest player @a ~ ~ ~ 2 0.8
playsound minecraft:entity.breeze.whirl player @a ~ ~ ~ 2 0.5
function ch:api/fx/screen {o:"storm",color:"#4FA8FF",in:1,stay:6,out:14}
title @s subtitle {text:"⛈ Eye of the Storm",color:"#4FA8FF",bold:true}
return 1
