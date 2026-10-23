# Phase $(p): Hrimvald's howl, and the winter deepens.
$scoreboard players set @s ch.frozen.ph $(p)
scoreboard players set @s ch.frozen.bt 0
particle minecraft:snowflake ~ ~2 ~ 3 3 3 0.2 300
particle minecraft:block{block_state:"minecraft:blue_ice"} ~ ~2 ~ 1 1.5 1 0.3 60
function ch:api/fx/pillar {model:"beam",color:15924223,w:3.0,h:24.0,t:5,life:24}
execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"dome",color:10217471,s0:1.0,s1:20.0,t:8,life:14,spin:90,dy:0.0}
function ch:api/fx/shake {s:3,t:20,r:60}
playsound chaoshearts:boss_phase master @a[distance=..90] ~ ~ ~ 2 1
playsound chaoshearts:boss_roar master @a[distance=..90] ~ ~ ~ 2 0.9
execute as @a[tag=ch.challenger,distance=..8] run function ch:api/push {s:1.0,y:0.5}
execute if score @s ch.frozen.ph matches 2 run function ch:trials/frozen/phase2
execute if score @s ch.frozen.ph matches 3 run function ch:trials/frozen/phase3
