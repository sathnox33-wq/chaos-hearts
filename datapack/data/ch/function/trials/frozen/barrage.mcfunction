# A fan of five ice shards.
function ch:trials/frozen/callout {t:"Hrimvald draws... shards incoming!"}
rotate @s facing entity @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] eyes
function ch:api/proj {item:"minecraft:ice",scale:0.6,speed:5,life:50,hit:"ch:trials/frozen/sh_hit",step:"ch:trials/frozen/sh_step",end:"ch:trials/frozen/sh_end",pierce:0,ignore:"ch.tmob"}
execute as @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.tmob,limit=1,sort=nearest] at @s run tp @s ~ ~ ~ ~-20 ~
tag @e[type=item_display,tag=ch.lnew,tag=ch.proj] add ch.tmob
function ch:api/proj {item:"minecraft:ice",scale:0.6,speed:5,life:50,hit:"ch:trials/frozen/sh_hit",step:"ch:trials/frozen/sh_step",end:"ch:trials/frozen/sh_end",pierce:0,ignore:"ch.tmob"}
execute as @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.tmob,limit=1,sort=nearest] at @s run tp @s ~ ~ ~ ~-10 ~
tag @e[type=item_display,tag=ch.lnew,tag=ch.proj] add ch.tmob
function ch:api/proj {item:"minecraft:ice",scale:0.6,speed:5,life:50,hit:"ch:trials/frozen/sh_hit",step:"ch:trials/frozen/sh_step",end:"ch:trials/frozen/sh_end",pierce:0,ignore:"ch.tmob"}
execute as @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.tmob,limit=1,sort=nearest] at @s run tp @s ~ ~ ~ ~0 ~
tag @e[type=item_display,tag=ch.lnew,tag=ch.proj] add ch.tmob
function ch:api/proj {item:"minecraft:ice",scale:0.6,speed:5,life:50,hit:"ch:trials/frozen/sh_hit",step:"ch:trials/frozen/sh_step",end:"ch:trials/frozen/sh_end",pierce:0,ignore:"ch.tmob"}
execute as @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.tmob,limit=1,sort=nearest] at @s run tp @s ~ ~ ~ ~10 ~
tag @e[type=item_display,tag=ch.lnew,tag=ch.proj] add ch.tmob
function ch:api/proj {item:"minecraft:ice",scale:0.6,speed:5,life:50,hit:"ch:trials/frozen/sh_hit",step:"ch:trials/frozen/sh_step",end:"ch:trials/frozen/sh_end",pierce:0,ignore:"ch.tmob"}
execute as @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.tmob,limit=1,sort=nearest] at @s run tp @s ~ ~ ~ ~20 ~
tag @e[type=item_display,tag=ch.lnew,tag=ch.proj] add ch.tmob
tag @e[type=item_display,tag=ch.lnew] remove ch.lnew
playsound minecraft:entity.skeleton.shoot master @a[distance=..90] ~ ~ ~ 2 0.6
playsound chaoshearts:frozen_shard master @a[distance=..90] ~ ~ ~ 1.5 0.7
