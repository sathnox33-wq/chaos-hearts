# Intro of The Rotting Garden: the title, spores rising, the sigil drinking the light, a slow wet heartbeat.
title @a[tag=ch.challenger] times 10 60 20
title @a[tag=ch.challenger] subtitle {text:"It does not want to kill you. It wants to keep you.",color:"#A4FF4F",italic:true}
title @a[tag=ch.challenger] title {text:"The Rotting Garden",color:"#7BD13A",bold:true}
playsound chaoshearts:corruption_spread master @a[tag=ch.challenger] ~ ~ ~ 1.5 0.6
playsound minecraft:block.sculk_catalyst.bloom master @a[tag=ch.challenger] ~ ~ ~ 1.5 0.5
particle minecraft:spore_blossom_air ~ ~4 ~ 14 4 14 0 400 force
particle minecraft:sculk_soul ~ ~1 ~ 6 0.5 6 0.03 80 force
execute positioned ~ ~1.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:4004434,s0:1.0,s1:20.0,t:40,life:80,spin:120,dy:0.0}
execute positioned ~ ~1.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:8114490,s0:0.5,s1:8.0,t:30,life:80,spin:-170,dy:0.0}
function ch:api/later {t:20,then:"ch:trials/corruption/intro2"}
function ch:api/later {t:40,then:"ch:trials/corruption/intro2"}
