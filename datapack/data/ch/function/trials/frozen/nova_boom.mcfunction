# The nova bursts.
execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"dome",color:10217471,s0:0.5,s1:12.0,t:4,life:9,spin:90,dy:0.0}
execute rotated 0 0 run function ch:api/fx/wave {color:15924223,r:6.0,t:5}
particle minecraft:snowflake ~ ~1 ~ 2 0.8 2 0.15 80
particle minecraft:block{block_state:"minecraft:ice"} ~ ~0.5 ~ 2 0.4 2 0.2 40
function ch:api/fx/shake {s:2,t:8,r:14}
playsound chaoshearts:frozen_nova master @a[distance=..60] ~ ~ ~ 2 0.8
execute positioned ~ ~1 ~ as @a[tag=ch.challenger,distance=..6] at @s run function ch:trials/frozen/nova_hit
