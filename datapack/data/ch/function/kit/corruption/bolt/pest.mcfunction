# Spend the full meter on a Pestilence Bolt.
scoreboard players set @s ch.corruption.m 0
tag @s remove ch.corruption.full
playsound minecraft:entity.wither.shoot player @a ~ ~ ~ 0.8 0.6
playsound minecraft:block.sculk_shrieker.shriek player @a ~ ~ ~ 0.5 1.4
function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:0,stay:3,out:10}
title @s subtitle {text:"Pestilence",color:"#A4FF4F",bold:true}
