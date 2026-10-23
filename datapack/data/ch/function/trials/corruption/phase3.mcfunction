# Phase 3: the rot spreads out from the sigil, a growing disc that poisons and burns - fight at the edge.
scoreboard players set @s ch.corruption.bp 3
scoreboard players set @s ch.v2 0
execute as @a[tag=ch.challenger,limit=1] run function ch:api/fx/screen {o:"corruption",color:"#3D1A52",in:2,stay:20,out:30}
title @a[tag=ch.challenger] times 5 40 15
title @a[tag=ch.challenger] title {text:"INFESTATION",color:"#7BD13A",bold:true}
title @a[tag=ch.challenger] subtitle {text:"The rot spreads from the centre. Fight at the edge!",color:"#A4FF4F",italic:true}
playsound chaoshearts:corruption_pandemic hostile @a ~ ~ ~ 2 0.6
playsound minecraft:block.sculk_shrieker.shriek hostile @a ~ ~ ~ 2 0.5
