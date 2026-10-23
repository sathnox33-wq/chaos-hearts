# Phase 2: she quickens; pustules and the brood join the rotation (the first brood hatches now).
scoreboard players set @s ch.corruption.bp 2
attribute @s minecraft:movement_speed base set 0.4
execute as @a[tag=ch.challenger,limit=1] run function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:2,stay:10,out:20}
playsound minecraft:entity.spider.ambient hostile @a ~ ~ ~ 3 0.3
particle minecraft:spore_blossom_air ~ ~3 ~ 6 3 6 0 200 force
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:8114490,r:14.0,t:10}
function ch:trials/corruption/brood
