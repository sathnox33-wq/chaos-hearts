# Phase 3: the Tempest.
effect give @s minecraft:speed 900 0 true
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1] run fill ~-12 ~-1 ~-12 ~12 ~-1 ~12 minecraft:sea_lantern replace minecraft:waxed_weathered_cut_copper
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1] positioned ~ ~0.2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:15267583,s0:2.0,s1:56.0,t:12,life:20,spin:170,dy:0.0}
title @a[tag=ch.challenger] subtitle {text:"Stand tall and the sky will find you",color:"#E8F6FF",bold:true}
function ch:trials/storm/fx/entrance
