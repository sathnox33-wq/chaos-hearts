# As the victim of a Colossus melee blow: a shockwave bursts from it and hurts everyone else nearby.
function ch:api/fx/wave {color:13214812,r:2.8,t:4}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16757575,s0:0.5,s1:3.5,t:3,life:6,spin:90,dy:0.0}
particle minecraft:block{block_state:"minecraft:stone"} ~ ~0.5 ~ 0.6 0.3 0.6 0.15 30
playsound minecraft:entity.iron_golem.attack player @a ~ ~ ~ 1 0.6
function ch:api/fx/shake {s:2,t:4,r:5}
scoreboard players set #ti_d ch.tmp 30
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.victim,distance=..2.5] run function ch:kit/titan/col/blow_hit
