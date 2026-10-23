# Updraft Column erupts: a pillar of wind launches everything standing on the mark.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
function ch:api/fx/pillar {model:"beam",color:16777215,w:2.4,h:14.0,t:3,life:10}
function ch:api/fx/pillar {model:"beam",color:15267583,w:4.0,h:10.0,t:4,life:12}
execute positioned ~ ~2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:16777215,s0:2.0,s1:5.0,t:6,life:10,spin:170,dy:8.0}
particle minecraft:gust_emitter_large ~ ~1 ~ 0 0 0 0 1
particle minecraft:cloud ~ ~4 ~ 0.6 4 0.6 0.2 80
playsound minecraft:entity.wind_charge.wind_burst player @a ~ ~ ~ 1.5 0.6
playsound chaoshearts:storm_gale player @a ~ ~ ~ 1.2 1.3
scoreboard players set #d ch.storm.g 30
scoreboard players operation #up ch.storm.g = @s ch.v2
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.8] at @s run function ch:kit/storm/gale/column_one
function ch:api/fx/shake {s:2,t:6,r:6}
