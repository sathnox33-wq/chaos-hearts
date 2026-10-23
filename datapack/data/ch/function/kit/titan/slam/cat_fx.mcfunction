# Cataclysm extra: a molten burst, a second ring and a pillar of dust.
function ch:api/fx/wave {color:16742954,r:5.5,t:8}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16757575,w:1.4,h:7.0,t:4,life:12}
particle minecraft:lava ~ ~0.4 ~ 1 0.2 1 0 16
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.2 0.6
function ch:api/fx/shake {s:3,t:10,r:12}
