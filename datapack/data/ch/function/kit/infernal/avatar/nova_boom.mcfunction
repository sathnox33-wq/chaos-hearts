# SUPERNOVA: a sun detonates; 14 damage, fire and a massive knockback within 7 blocks.
particle minecraft:explosion_emitter ~ ~1 ~ 1.5 0.5 1.5 0 4
particle minecraft:end_rod ~ ~1 ~ 0.3 0.3 0.3 0.5 40
$particle $(fl) ~ ~1 ~ 3 2 3 0.35 300
particle minecraft:lava ~ ~1 ~ 3 1 3 0 60
particle minecraft:large_smoke ~ ~2 ~ 3 2 3 0.08 80
$function ch:api/fx/orb {color:$(c3),s:15.0,t:4,life:10}
$function ch:api/fx/orb {color:$(c),s:11.0,t:6,life:12}
$execute rotated 0 0 run function ch:api/fx/wave {color:$(c),r:12.0,t:8}
$function ch:api/fx/sprite {model:"star",color:$(c3),s0:2.0,s1:18.0,t:6,life:10,spin:170,dy:0.0}
$function ch:api/fx/sprite {model:"swirl",color:$(c2),s0:3.0,s1:16.0,t:12,life:16,spin:170,dy:5.0}
$function ch:api/fx/pillar {model:"flame",color:$(c),w:8.0,h:14.0,t:5,life:14}
$function ch:api/fx/screen {o:"flash",color:"$(hex)",in:0,stay:3,out:12}
function ch:api/fx/light {t:12}
function ch:api/fx/shake {s:3,t:20,r:24}
playsound chaoshearts:infernal_eruption player @a ~ ~ ~ 3 0.7
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 2 0.5
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 1 0.6
scoreboard players set #i_dmg ch.tmp 140
scoreboard players set #i_ft ch.tmp 160
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..7] run function ch:kit/infernal/avatar/nova_one
