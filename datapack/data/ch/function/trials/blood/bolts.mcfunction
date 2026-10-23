# Phase 3, under her Blood Moon: three bolts of blood fall (one on the challenger) after 25 ticks of warning.
execute at @a[tag=ch.challenger,distance=..80,limit=1] run summon marker ~ ~ ~ {Tags:["ch.blood.bolt","ch.blood.bnw","ch.tmob","ch.noability"]}
execute at @a[tag=ch.challenger,distance=..80,limit=1] run summon marker ~ ~ ~ {Tags:["ch.blood.bolt","ch.blood.bnw","ch.blood.bsp","ch.tmob","ch.noability"]}
execute at @a[tag=ch.challenger,distance=..80,limit=1] run summon marker ~ ~ ~ {Tags:["ch.blood.bolt","ch.blood.bnw","ch.blood.bsp","ch.tmob","ch.noability"]}
execute at @a[tag=ch.challenger,distance=..80,limit=1] run spreadplayers ~ ~ 2 6 under 104 false @e[type=marker,tag=ch.blood.bsp,tag=ch.blood.bnw]
scoreboard players set @e[type=marker,tag=ch.blood.bnw] ch.life 25
execute as @e[type=marker,tag=ch.blood.bnw] at @s run function ch:trials/blood/bolt_mark
tag @e[type=marker,tag=ch.blood.bnw] remove ch.blood.bnw
playsound minecraft:entity.wither.shoot master @a[distance=..90] ~ ~ ~ 1.5 0.5
