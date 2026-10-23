# Phase 2: the Sovereign quickens, Voidlings pour out, and the lances begin.
scoreboard players set @s ch.void.bp 2
attribute @s minecraft:movement_speed base set 0.38
execute as @a[tag=ch.challenger,limit=1] run function ch:api/fx/screen {o:"void",color:"#8A3CFF",in:2,stay:10,out:20}
execute as @a[tag=ch.challenger,limit=1] run function ch:core/msg/say {m:"The Sovereign splits the sky. Watch for its lances.",c:"#D38CFF"}
playsound minecraft:entity.enderman.scream hostile @a ~ ~ ~ 2 0.4
particle minecraft:reverse_portal ~ ~2 ~ 2 2 2 0.5 200 force
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:13864191,r:14.0,t:10}
execute at @e[type=marker,tag=ch.session,limit=1,sort=nearest] run function ch:trials/void/phase_adds
