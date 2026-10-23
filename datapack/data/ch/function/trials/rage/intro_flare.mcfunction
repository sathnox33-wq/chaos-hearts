# A war pillar ignites (marker at its top).
function ch:api/fx/pillar {model:"flame",color:16738847,w:2.2,h:4.0,t:4,life:40}
function ch:api/fx/orb {color:14689835,s:3.0,t:4,life:12}
particle minecraft:flame ~ ~1 ~ 0.6 0.6 0.6 0.08 30
particle minecraft:lava ~ ~0.5 ~ 0.5 0.2 0.5 0 6
playsound minecraft:item.firecharge.use master @a[distance=..90] ~ ~ ~ 1.5 0.6
playsound minecraft:entity.blaze.shoot master @a[distance=..90] ~ ~ ~ 1 0.5
