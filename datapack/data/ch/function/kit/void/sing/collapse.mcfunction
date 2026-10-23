# The collapse: a white flash, a sonic shell, huge damage near the core, everything flung out, Event Horizon feat.
scoreboard players operation #vd ch.tmp = @s ch.v4
scoreboard players set #hits ch.tmp 0
execute if entity @s[tag=ch.void.mini] as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4,limit=16] run function ch:kit/void/sing/blast
execute unless entity @s[tag=ch.void.mini] as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6,limit=24] run function ch:kit/void/sing/blast
playsound chaoshearts:void_collapse player @a ~ ~ ~ 2 0.8
playsound minecraft:entity.warden.sonic_boom player @a ~ ~ ~ 2 0.6
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 2 0.5
particle minecraft:explosion_emitter ~ ~ ~ 0.5 0.5 0.5 0 2
particle minecraft:reverse_portal ~ ~ ~ 0.3 0.3 0.3 1.6 200
particle minecraft:dust{color:[0.541,0.235,1.0],scale:3.0} ~ ~ ~ 3 3 3 0 80
particle minecraft:end_rod ~ ~ ~ 0.2 0.2 0.2 0.6 40
function ch:api/fx/ring {p:"minecraft:sonic_boom",r:3}
execute rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:15259903,s0:0.5,s1:11.0,t:4,life:7,spin:90,dy:0.0}
function ch:api/fx/orb {color:9059583,s:8.0,t:4,life:8}
function ch:api/fx/sprite {model:"star",color:15259903,s0:0.5,s1:7.0,t:2,life:6,spin:170,dy:0.0}
execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:1.0,s1:22.0,t:6,life:9,spin:170,dy:0.0}
execute rotated 0 75 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:1.0,s1:16.0,t:5,life:8,spin:-170,dy:0.0}
execute positioned ~ ~-1.4 ~ run function ch:api/fx/wave {color:9059583,r:10.0,t:8}
function ch:api/fx/light {t:8}
function ch:api/fx/shake {s:3,t:12,r:24}
execute as @a[distance=..20] run function ch:api/fx/screen {o:"flash",color:"#E8D8FF",in:0,stay:2,out:12}
execute if score @s ch.v3 matches 4.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"void",n:3}
execute as @e[type=item_display,tag=ch.void.sd,distance=..6] if score @s ch.void.sid = #sid ch.tmp run kill @s
kill @s
