# Level: the outbreak wave and an infection in every enemy within 15 blocks; Outbreak feat at 5.
scoreboard players set #cn ch.tmp 0
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
particle minecraft:dust{color:[0.482,0.82,0.227],scale:2.4} ~ ~0.5 ~ 4 0.3 4 0 120
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:8114490,s0:1.0,s1:30.0,t:10,life:13,spin:170,dy:0.0}
execute positioned ~ ~0.2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:4004434,s0:0.5,s1:26.0,t:12,life:15,spin:-170,dy:0.0}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:2046478,s0:1.0,s1:14.0,t:10,life:40,spin:90,dy:0.0}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:8114490,r:15.0,t:10}
execute positioned ~ ~1 ~ run function ch:api/fx/pillar {model:"beam",color:8114490,w:1.6,h:12.0,t:5,life:16}
execute positioned ~ ~2 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"skull",color:10813263,s0:0.5,s1:4.0,t:6,life:16,spin:0,dy:3.0}
function ch:api/fx/shake {s:3,t:10,r:20}
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=ch.corruption.host,distance=..15] run function ch:kit/corruption/inf/check_live
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.corruption.host,distance=..15,limit=16] at @s run function ch:kit/corruption/pan/infect
execute if score #cn ch.tmp matches 5.. run function ch:api/feat {h:"corruption",n:3}
