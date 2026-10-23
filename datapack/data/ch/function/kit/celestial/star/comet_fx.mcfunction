# Comet: a burning crater, an explosion and a much wider shockwave.
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
particle minecraft:flame ~ ~0.5 ~ 1.5 0.3 1.5 0.08 60
particle minecraft:lava ~ ~0.5 ~ 1 0.3 1 0 12
function ch:api/fx/wave {color:16763210,r:7,t:8}
execute positioned ~ ~0.04 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16763210,s0:0.6,s1:6.0,t:3,life:40,spin:0,dy:0.0}
playsound chaoshearts:celestial_comet player @a ~ ~ ~ 1.4 1
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.2 1.2
function ch:api/fx/shake {s:3,t:10,r:14}
