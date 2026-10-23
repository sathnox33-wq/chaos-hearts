# A mortar shell lands: a splash of liquid fire 2.5 blocks wide.
$particle $(fl) ~ ~0.3 ~ 1 0.3 1 0.1 40
particle minecraft:lava ~ ~0.3 ~ 0.8 0.2 0.8 0 8
particle minecraft:explosion ~ ~0.5 ~ 0.5 0.2 0.5 0 3
particle minecraft:large_smoke ~ ~0.8 ~ 0.6 0.4 0.6 0.02 10
$function ch:api/fx/orb {color:$(c3),s:3.0,t:3,life:7}
$execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:$(c),s0:0.5,s1:5.5,t:5,life:9,spin:120,dy:0.0}
$execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"crack",color:$(c2),s0:1.0,s1:4.0,t:3,life:30,spin:0,dy:0.0}
$function ch:api/fx/sprite3 {model:"flame",color:$(c),a:"[1.5,0.2,1.5]",b:"[2.5,2.8,2.5]",t:4,life:9,spin:120}
function ch:api/fx/light {t:5}
function ch:api/fx/shake {s:2,t:6,r:9}
playsound chaoshearts:infernal_burst player @a ~ ~ ~ 1.2 0.9
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.6 1.3
scoreboard players operation #i_bd ch.tmp = #i_dmg ch.tmp
scoreboard players set #i_ft ch.tmp 80
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.5] run function ch:kit/infernal/volley/blast_one
