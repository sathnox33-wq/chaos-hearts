# Oblivion: instead of swapping, the target is hurled high into the sky.
execute at @e[tag=ch.void.dt,limit=1] run function ch:kit/void/disp/portal
execute at @e[tag=ch.void.dt,limit=1] rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:9059583,w:1.4,h:16.0,t:6,life:16}
execute at @e[tag=ch.void.dt,limit=1] run playsound minecraft:entity.shulker.shoot player @a ~ ~ ~ 1 0.5
execute at @e[tag=ch.void.dt,limit=1] run particle minecraft:reverse_portal ~ ~2 ~ 0.3 3 0.3 0.1 120
execute as @e[tag=ch.void.dt,limit=1,type=!player,tag=!ch.boss] run data modify entity @s Motion set value [0.0d,2.1d,0.0d]
execute as @e[tag=ch.void.dt,limit=1,type=player] run function ch:api/cc {effect:"minecraft:levitation",sec:2,amp:14}
execute as @e[tag=ch.void.dt,limit=1] run function ch:api/hit {d:30}
