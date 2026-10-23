# Intro of The Hollow Beneath: the title, then the island answers - pillars of light, rings of nothing, a low call.
title @a[tag=ch.challenger] times 10 60 20
title @a[tag=ch.challenger] subtitle {text:"Stare into nothing long enough and it learns your name.",color:"#D38CFF",italic:true}
title @a[tag=ch.challenger] title {text:"The Hollow Beneath",color:"#8A3CFF",bold:true}
playsound chaoshearts:void_rift master @a[tag=ch.challenger] ~ ~ ~ 1.5 0.6
playsound minecraft:block.end_portal.spawn master @a[tag=ch.challenger] ~ ~ ~ 0.8 0.6
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:9059583,w:2.0,h:30.0,t:20,life:80}
execute positioned ~ ~1.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:1.0,s1:50.0,t:30,life:40,spin:170,dy:0.0}
execute positioned ~ ~22 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:1310763,s0:1.0,s1:24.0,t:40,life:80,spin:170,dy:0.0}
particle minecraft:reverse_portal ~ ~2 ~ 3 6 3 0.2 400 force
function ch:api/later {t:20,then:"ch:trials/void/intro2"}
function ch:api/later {t:45,then:"ch:trials/void/intro2"}
