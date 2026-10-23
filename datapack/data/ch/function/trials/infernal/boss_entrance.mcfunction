# Entrance: a column of fire splits the floor.
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
particle minecraft:flame ~ ~2 ~ 1.5 2 1.5 0.15 200
particle minecraft:lava ~ ~1 ~ 1 1 1 0 40
function ch:api/fx/pillar {model:"flame",color:16742938,w:4.0,h:14.0,t:6,life:24}
function ch:api/fx/pillar {model:"beam",color:16765503,w:1.5,h:30.0,t:4,life:20}
execute rotated 0 0 run function ch:api/fx/wave {color:16742938,r:14.0,t:10}
function ch:api/fx/shake {s:3,t:20,r:60}
function ch:api/fx/light {t:20}
playsound chaoshearts:boss_roar master @a[distance=..90] ~ ~ ~ 2 0.7
playsound minecraft:entity.blaze.death master @a[distance=..90] ~ ~ ~ 2 0.4
playsound chaoshearts:infernal_burst master @a[distance=..90] ~ ~ ~ 2 0.7
