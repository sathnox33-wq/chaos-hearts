# A mob claws its way out of the fire.
function ch:api/fx/pillar {model:"flame",color:16742938,w:1.6,h:4.0,t:4,life:12}
particle minecraft:flame ~ ~1 ~ 0.4 0.8 0.4 0.08 30
particle minecraft:lava ~ ~0.5 ~ 0.3 0.2 0.3 0 6
playsound minecraft:item.firecharge.use master @a[distance=..60] ~ ~ ~ 1 0.7
