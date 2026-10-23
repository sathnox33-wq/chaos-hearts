# A pillar top bursts into flame.
function ch:api/fx/pillar {model:"flame",color:16742938,w:2.5,h:7.0,t:5,life:20}
function ch:api/fx/pillar {model:"beam",color:16765503,w:0.6,h:14.0,t:4,life:16}
particle minecraft:flame ~ ~1 ~ 0.5 1 0.5 0.1 60
particle minecraft:lava ~ ~1 ~ 0.4 0.4 0.4 0 10
function ch:api/fx/light {t:20}
playsound minecraft:item.firecharge.use master @a[distance=..90] ~ ~ ~ 2 0.6
