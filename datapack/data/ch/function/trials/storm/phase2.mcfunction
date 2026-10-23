# Phase 2: the copper inlays light up and static begins.
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1] run fill ~-22 ~-1 ~-22 ~22 ~-1 ~22 minecraft:waxed_copper_block replace minecraft:waxed_oxidized_cut_copper
title @a[tag=ch.challenger] subtitle {text:"The copper hums with power",color:"#4FA8FF",bold:true}
function ch:trials/storm/fx/entrance
scoreboard players set @s ch.v5 200
