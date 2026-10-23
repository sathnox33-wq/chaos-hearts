# A meteor lands: a 3-block blast for 1.5x damage that cracks the ground and shakes the screen.
$particle $(fl) ~ ~ ~ 1.2 1.2 1.2 0.12 70
particle minecraft:lava ~ ~ ~ 0.8 0.5 0.8 0 16
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1
particle minecraft:large_smoke ~ ~1 ~ 1 1 1 0.05 30
particle minecraft:block{block_state:"minecraft:magma_block"} ~ ~ ~ 1 0.6 1 0.4 50
$function ch:api/fx/orb {color:$(c3),s:5.0,t:4,life:9}
$execute rotated 0 0 run function ch:api/fx/wave {color:$(c),r:4.0,t:6}
$execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"crack",color:$(c2),s0:2.0,s1:6.0,t:3,life:40,spin:0,dy:0.0}
$function ch:api/fx/sprite {model:"swirl",color:$(c),s0:1.0,s1:6.0,t:8,life:12,spin:170,dy:1.5}
$function ch:api/fx/pillar {model:"flame",color:$(c),w:3.0,h:5.0,t:4,life:10}
function ch:api/fx/light {t:6}
function ch:api/fx/shake {s:3,t:10,r:14}
playsound chaoshearts:infernal_meteor player @a ~ ~ ~ 1.6 1
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.2 0.7
scoreboard players operation #i_bd ch.tmp = #i_dmg ch.tmp
scoreboard players operation #i_bd ch.tmp *= #2 ch.g
scoreboard players operation #i_bd ch.tmp -= #i_dmg ch.tmp
scoreboard players operation #i_dmg ch.tmp /= #2 ch.g
scoreboard players operation #i_bd ch.tmp += #i_dmg ch.tmp
scoreboard players set #i_ft ch.tmp 100
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3] run function ch:kit/infernal/volley/blast_one
