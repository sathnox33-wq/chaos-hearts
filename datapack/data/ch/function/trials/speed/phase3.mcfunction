# Phase 3: the clock races.
effect give @s minecraft:speed 900 1 true
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1] run fill ~-13 ~-1 ~-13 ~13 ~-1 ~13 minecraft:orange_concrete replace minecraft:yellow_concrete
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1] positioned ~ ~0.2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16113986,s0:2.0,s1:56.0,t:12,life:20,spin:170,dy:0.0}
title @a[tag=ch.challenger] subtitle {text:"Every second you waste is a second it steals",color:"#F5E142",bold:true}
function ch:trials/speed/fx/entrance
