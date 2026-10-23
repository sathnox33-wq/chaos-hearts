# Meteor impact: 8 damage within 2.8 blocks.
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
particle minecraft:flame ~ ~0.5 ~ 1.2 0.5 1.2 0.1 50
particle minecraft:lava ~ ~0.5 ~ 0.8 0.3 0.8 0 20
particle minecraft:block{block_state:"minecraft:magma_block"} ~ ~0.5 ~ 1 0.5 1 0.4 40
function ch:api/fx/orb {color:16765503,s:5.0,t:3,life:8}
execute rotated 0 0 run function ch:api/fx/wave {color:16742938,r:3.5,t:6}
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:9182208,s0:2.0,s1:6.0,t:3,life:60,spin:0,dy:0.0}
function ch:api/fx/shake {s:2,t:8,r:14}
function ch:api/fx/light {t:6}
playsound chaoshearts:infernal_meteor master @a[distance=..60] ~ ~ ~ 1.6 1
playsound minecraft:entity.generic.explode master @a[distance=..60] ~ ~ ~ 1.2 0.8
execute as @a[tag=ch.challenger,distance=..2.8] at @s run function ch:trials/infernal/hit {d:80}
kill @s
