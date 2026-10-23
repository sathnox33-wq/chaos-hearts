# Every half second of Vortex Lap: pull, cut and slow everything inside.
tag @s add ch.caster
playsound minecraft:entity.breeze.whirl player @a ~ ~ ~ 1 0.8
scoreboard players set #d ch.speed.g 15
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..7] at @s run function ch:kit/speed/slip/orbit
tag @s remove ch.caster
