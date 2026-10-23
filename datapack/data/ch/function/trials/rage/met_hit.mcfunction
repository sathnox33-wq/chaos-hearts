# Meteor impact: 8 damage within 2.8.
tag @e[type=ravager,tag=ch.rage.boss,distance=..80,limit=1] add ch.caster
execute as @a[tag=ch.challenger,distance=..2.8] run function ch:trials/rage/met_dmg
tag @e[tag=ch.caster] remove ch.caster
particle minecraft:explosion ~ ~0.5 ~ 0.6 0.2 0.6 0 3
particle minecraft:lava ~ ~0.5 ~ 1 0.3 1 0 15
particle minecraft:block{block_state:"minecraft:magma_block"} ~ ~0.4 ~ 1 0.3 1 0.3 40
function ch:api/fx/wave {color:16738847,r:3.0,t:5}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16738847,s0:1.0,s1:5.0,t:2,life:40,spin:0,dy:0.0}
function ch:api/fx/shake {s:2,t:6,r:8}
playsound minecraft:entity.generic.explode master @a[distance=..90] ~ ~ ~ 1.2 1.1
kill @s
