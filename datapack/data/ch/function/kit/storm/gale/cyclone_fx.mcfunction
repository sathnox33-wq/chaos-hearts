# The cyclone's funnel: stacked spinning swirls and a helix of cloud.
execute positioned ~ ~0.3 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:16777215,s0:6.0,s1:7.0,t:3,life:4,spin:170,dy:0.0}
execute positioned ~ ~2.0 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:15267583,s0:8.0,s1:9.0,t:3,life:4,spin:-170,dy:0.0}
execute positioned ~ ~3.8 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:5220607,s0:10.0,s1:11.0,t:3,life:4,spin:170,dy:0.0}
execute rotated as @s positioned ^ ^0.5 ^3 run particle minecraft:cloud ~ ~ ~ 0.1 0.1 0.1 0.02 3
execute rotated as @s positioned ^ ^2 ^-4 run particle minecraft:cloud ~ ~ ~ 0.1 0.1 0.1 0.02 3
execute rotated as @s positioned ^3.5 ^3.5 ^ run particle minecraft:cloud ~ ~ ~ 0.1 0.1 0.1 0.02 3
execute at @s run tp @s ~ ~ ~ ~37 0
execute if score #t10 ch.storm.g matches 0 run playsound minecraft:entity.breeze.idle_air player @a ~ ~ ~ 1.5 0.6
