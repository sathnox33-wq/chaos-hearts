# Phase $(p): Ignaroth roars and the throne room burns hotter.
$scoreboard players set @s ch.infernal.ph $(p)
scoreboard players set @s ch.infernal.bt 0
particle minecraft:explosion_emitter ~ ~2 ~ 0 0 0 0 1
particle minecraft:flame ~ ~2 ~ 2 2 2 0.2 200
function ch:api/fx/pillar {model:"flame",color:16742938,w:5.0,h:16.0,t:6,life:24}
execute rotated 0 0 run function ch:api/fx/wave {color:16765503,r:12.0,t:8}
function ch:api/fx/shake {s:3,t:20,r:60}
playsound chaoshearts:boss_phase master @a[distance=..90] ~ ~ ~ 2 1
playsound chaoshearts:boss_roar master @a[distance=..90] ~ ~ ~ 2 0.6
execute as @a[tag=ch.challenger,distance=..8] run function ch:api/push {s:1.0,y:0.5}
execute if score @s ch.infernal.ph matches 2 run function ch:trials/infernal/phase2
execute if score @s ch.infernal.ph matches 3 run function ch:trials/infernal/phase3
