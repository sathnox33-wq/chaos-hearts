# Intro: the spikes flash one by one, snow howls across the field and the lake glows.
title @a[tag=ch.challenger,distance=..90] times 10 70 20
title @a[tag=ch.challenger,distance=..90] subtitle {text:"Keep moving. The cold only kills the still.",color:"#C8F0FF",italic:true}
title @a[tag=ch.challenger,distance=..90] title {text:"THE LAST WINTER",color:"#9BE7FF",bold:true}
playsound chaoshearts:trial_intro master @a[distance=..90] ~ ~ ~ 1 1
playsound chaoshearts:trial_music_frozen record @a[distance=..90] ~ ~ ~ 0.7 1
playsound chaoshearts:frozen_blizzard master @a[distance=..90] ~ ~ ~ 2 0.7
execute rotated 0 0 run function ch:api/fx/wave {color:10217471,r:26.0,t:20}
execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"hex",color:6273256,s0:1.0,s1:11.0,t:20,life:60,spin:170,dy:0.0}
particle minecraft:snowflake ~ ~8 ~ 20 6 20 0.05 400
function ch:api/later {t:4,then:"ch:trials/frozen/intro_spike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~20 ~1 ~8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:9,then:"ch:trials/frozen/intro_spike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~8 ~1 ~20
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:14,then:"ch:trials/frozen/intro_spike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~-8 ~1 ~20
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:19,then:"ch:trials/frozen/intro_spike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~-20 ~1 ~8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:24,then:"ch:trials/frozen/intro_spike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~-20 ~1 ~-8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:29,then:"ch:trials/frozen/intro_spike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~-8 ~1 ~-20
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:34,then:"ch:trials/frozen/intro_spike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~8 ~1 ~-20
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:39,then:"ch:trials/frozen/intro_spike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run tp @s ~20 ~1 ~-8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
