# Vortex Lap ends: everything in the cyclone is flung out.
tag @s add ch.caster
scoreboard players set #d ch.speed.g 50
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..7] at @s run function ch:kit/speed/slip/fling_one
function ch:api/fx/wave {color:2741234,r:7.0,t:6}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:16777215,s0:2.0,s1:12.0,t:4,life:7,spin:-170,dy:0.0}
particle minecraft:gust_emitter_large ~ ~1 ~ 0 0 0 0 1
playsound minecraft:entity.breeze.wind_burst player @a ~ ~ ~ 1.5 0.7
playsound chaoshearts:speed_slipstream player @a ~ ~ ~ 1 0.7
function ch:api/fx/shake {s:2,t:8,r:9}
tag @s remove ch.caster
