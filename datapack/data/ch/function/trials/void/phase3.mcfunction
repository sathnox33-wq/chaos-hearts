# Phase 3: Event Horizon - a singularity opens over the centre and never stops pulling; the floor starts to crack.
scoreboard players set @s ch.void.bp 3
execute as @a[tag=ch.challenger,limit=1] run function ch:api/fx/screen {o:"void",color:"#14002B",in:2,stay:20,out:30}
title @a[tag=ch.challenger] times 5 40 15
title @a[tag=ch.challenger] title {text:"EVENT HORIZON",color:"#8A3CFF",bold:true}
title @a[tag=ch.challenger] subtitle {text:"Resist the pull.",color:"#D38CFF",italic:true}
playsound chaoshearts:void_singularity hostile @a ~ ~ ~ 2 0.5
playsound minecraft:block.end_portal.spawn hostile @a ~ ~ ~ 1.5 0.6
execute at @e[type=marker,tag=ch.session,limit=1,sort=nearest] positioned ~ ~3 ~ run function ch:trials/void/horizon_spawn
