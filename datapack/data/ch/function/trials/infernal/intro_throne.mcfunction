# The throne erupts.
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1
particle minecraft:flame ~ ~2 ~ 2 3 1 0.15 200
function ch:api/fx/pillar {model:"flame",color:16742938,w:6.0,h:12.0,t:6,life:30}
function ch:api/fx/orb {color:16765503,s:6.0,t:5,life:16}
function ch:api/fx/shake {s:2,t:16,r:60}
playsound chaoshearts:infernal_eruption master @a[distance=..90] ~ ~ ~ 3 0.6
