# Intro: the pillars ignite one by one, the throne flares and the floor's veins light up.
title @a[tag=ch.challenger,distance=..90] times 10 70 20
title @a[tag=ch.challenger,distance=..90] subtitle {text:"Walk through fire, or become its fuel.",color:"#FFB070",italic:true}
title @a[tag=ch.challenger,distance=..90] title {text:"THE CINDER THRONE",color:"#FF7A1A",bold:true}
playsound chaoshearts:trial_intro master @a[distance=..90] ~ ~ ~ 1 1
playsound chaoshearts:trial_music_infernal record @a[distance=..90] ~ ~ ~ 0.7 1
playsound minecraft:entity.blaze.ambient master @a[distance=..90] ~ ~ ~ 2 0.5
execute rotated 0 0 run function ch:api/fx/wave {color:16742938,r:26.0,t:20}
function ch:api/later {t:4,then:"ch:trials/infernal/intro_pillar"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~20 ~13 ~8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:9,then:"ch:trials/infernal/intro_pillar"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~8 ~13 ~20
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:14,then:"ch:trials/infernal/intro_pillar"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~-8 ~13 ~20
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:19,then:"ch:trials/infernal/intro_pillar"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~-20 ~13 ~8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:24,then:"ch:trials/infernal/intro_pillar"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~-20 ~13 ~-8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:29,then:"ch:trials/infernal/intro_pillar"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~-8 ~13 ~-20
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:34,then:"ch:trials/infernal/intro_pillar"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~8 ~13 ~-20
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:39,then:"ch:trials/infernal/intro_pillar"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~20 ~13 ~-8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:50,then:"ch:trials/infernal/intro_throne"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~ ~4 ~-25
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
