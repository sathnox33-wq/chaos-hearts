# Phase 2: the track turns cyan and Vael quickens.
effect give @s minecraft:speed 900 0 true
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1] run fill ~-15 ~-1 ~-15 ~15 ~-1 ~15 minecraft:cyan_concrete replace minecraft:light_blue_concrete
title @a[tag=ch.challenger] subtitle {text:"Vael begins to steal time",color:"#29D3F2",bold:true}
function ch:trials/speed/fx/entrance
scoreboard players set @s ch.v5 200
