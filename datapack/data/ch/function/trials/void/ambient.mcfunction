# The Hollow Beneath, every tick of the fight: drifting portal light and ash around the challenger, distant tears in
# the sky, the trial's rifts and cracks, and the Event Horizon in phase 3.
execute at @a[tag=ch.challenger,limit=1] run particle minecraft:portal ~ ~1 ~ 8 2 8 0.2 4
execute at @a[tag=ch.challenger,limit=1] run particle minecraft:white_ash ~ ~3 ~ 8 3 8 0 6
scoreboard players operation #vb ch.tmp = #now ch.g
scoreboard players operation #vb ch.tmp %= #100 ch.void.k
execute if score #vb ch.tmp matches 0 positioned ~18 ~16 ~-20 rotated 40 90 run function ch:api/fx/sprite3 {model:"crack",color:9059583,a:"[0.5,0.5,0.5]",b:"[5.0,9.0,5.0]",t:20,life:40,spin:0}
execute if score #vb ch.tmp matches 50 positioned ~-22 ~20 ~14 rotated 200 90 run function ch:api/fx/sprite3 {model:"crack",color:13864191,a:"[0.5,0.5,0.5]",b:"[4.0,8.0,4.0]",t:20,life:40,spin:0}
execute if entity @e[type=marker,tag=ch.void.trift,distance=..60,limit=1] as @e[type=marker,tag=ch.void.trift,distance=..60] at @s run function ch:trials/void/trift_tick
execute if entity @e[type=marker,tag=ch.void.tzone,distance=..60,limit=1] as @e[type=marker,tag=ch.void.tzone,distance=..60] at @s run function ch:trials/void/tzone_tick
execute if entity @e[tag=ch.boss,scores={ch.void.bp=3..},distance=..80,limit=1] run function ch:trials/void/horizon
