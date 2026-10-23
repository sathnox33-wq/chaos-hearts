# Up: Titanfall. Leap skyward; a wide crater is marked below, and where you land you rise as a Colossus.
function ch:api/leap {n:3}
scoreboard players set @s ch.titan.air 60
scoreboard players set @s ch.titan.airt 0
scoreboard players set @s ch.titan.airm 1
scoreboard players set @s ch.titan.ad 100
scoreboard players set @s ch.titan.acat 0
attribute @s minecraft:fall_damage_multiplier modifier add ch:titan_fall -1 add_multiplied_total
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:13214812,w:1.2,h:10.0,t:4,life:10}
function ch:api/fx/wave {color:13214812,r:4,t:6}
function ch:kit/titan/fx/debris
particle minecraft:gust ~ ~0.2 ~ 0.4 0 0.4 0 3
playsound minecraft:entity.breeze.wind_burst player @a ~ ~ ~ 1.2 0.5
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 1.2 0.8
return 1
