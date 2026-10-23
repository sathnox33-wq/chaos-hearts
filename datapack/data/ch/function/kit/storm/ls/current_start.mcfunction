# Ground Current: lightning races along the floor in front of you, rooting what it touches.
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.cur","ch.noability","ch.storm.cnew"]}
execute rotated ~ 0 run tp @e[type=marker,tag=ch.storm.cnew,limit=1] ~ ~ ~ ~ ~
scoreboard players operation @e[type=marker,tag=ch.storm.cnew,limit=1] ch.owner = @s ch.pid
scoreboard players set @e[type=marker,tag=ch.storm.cnew,limit=1] ch.life 16
scoreboard players operation #e ch.storm.g = @s ch.pid
scoreboard players add #cidn ch.storm.g 1
scoreboard players operation @e[type=marker,tag=ch.storm.cnew,limit=1] ch.v2 = #cidn ch.storm.g
scoreboard players set @e[type=marker,tag=ch.storm.cnew,limit=1] ch.v1 50
execute if score @s ch.b1 matches 1.. run scoreboard players set @e[type=marker,tag=ch.storm.cnew,limit=1] ch.v1 60
tag @e[type=marker,tag=ch.storm.cnew] remove ch.storm.cnew
playsound chaoshearts:storm_chain player @a ~ ~ ~ 1 0.7
playsound minecraft:entity.lightning_bolt.impact player @a ~ ~ ~ 1 0.6
function ch:api/fx/wave {color:5220607,r:2.0,t:4}
title @s subtitle {text:"Ground Current",color:"#4FA8FF",italic:true}
return 1
