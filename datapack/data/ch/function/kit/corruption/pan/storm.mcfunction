# Up: a rotting storm cloud gathers 8 blocks over you and rains plague for 8 seconds.
execute positioned ~ ~8 ~ run summon marker ~ ~ ~ {Tags:["ch.corruption.storm","ch.corruption.snew","ch.noability"]}
execute as @e[type=marker,tag=ch.corruption.snew,limit=1] run function ch:kit/corruption/pan/storm_init
execute positioned ~ ~8 ~ rotated 0 0 run function ch:api/fx/sprite {model:"cloud",color:4004434,s0:1.0,s1:14.0,t:20,life:160,spin:60,dy:0.0}
execute positioned ~2 ~8.6 ~-1 rotated 120 0 run function ch:api/fx/sprite {model:"cloud",color:8114490,s0:1.0,s1:10.0,t:24,life:156,spin:-60,dy:0.0}
execute positioned ~-2 ~7.6 ~1.5 rotated 240 0 run function ch:api/fx/sprite {model:"cloud",color:2046478,s0:1.0,s1:12.0,t:22,life:158,spin:45,dy:0.0}
execute positioned ~ ~7.5 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:13161514,s0:1.0,s1:30.0,t:20,life:160,spin:170,dy:0.0}
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 0.6 0.5
playsound minecraft:weather.rain.above player @a ~ ~ ~ 1 0.5
