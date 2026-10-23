# The cyclone flings everything out.
scoreboard players set #d ch.storm.g 40
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..8] at @s run function ch:kit/storm/gale/fling_one
particle minecraft:gust_emitter_large ~ ~1.5 ~ 0 0 0 0 1
function ch:api/fx/wave {color:16777215,r:8.0,t:6}
playsound minecraft:entity.wind_charge.wind_burst player @a ~ ~ ~ 1.5 0.5
playsound chaoshearts:storm_gale player @a ~ ~ ~ 1 0.7
function ch:api/fx/shake {s:2,t:8,r:10}
