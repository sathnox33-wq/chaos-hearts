# Wrathfall: the launch. The landing (see leap/land) is the meteor and starts the Rampage.
scoreboard players set @s ch.rage.lv 3
scoreboard players set @s ch.rage.leap 90
scoreboard players set @s ch.rage.rv 0
function ch:kit/rage/leap/start
execute rotated ~ -90 run function ch:api/leap {n:3}
function ch:api/fx/pillar {model:"flame",color:16738847,w:1.6,h:6.0,t:3,life:10}
function ch:api/fx/pillar {model:"beam",color:14689835,w:1.0,h:14.0,t:4,life:14}
particle minecraft:explosion ~ ~0.3 ~ 0.6 0.1 0.6 0 4
particle minecraft:lava ~ ~0.3 ~ 0.6 0.1 0.6 0 10
function ch:api/fx/shake {s:2,t:8,r:12}
playsound minecraft:entity.ender_dragon.growl player @a ~ ~ ~ 0.8 1.4
playsound minecraft:entity.firework_rocket.launch player @a ~ ~ ~ 1.4 0.5
return 1
