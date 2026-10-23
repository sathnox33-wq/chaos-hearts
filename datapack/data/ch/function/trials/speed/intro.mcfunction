# The Racing Hour opens: the clock face lights up ring by ring while the hands begin to turn.
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16113986,s0:1.0,s1:56.0,t:30,life:60,spin:170,dy:0.0}
execute positioned ~ ~0.2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:2741234,s0:0.5,s1:16.0,t:40,life:80,spin:170,dy:0.0}
execute positioned ~ ~12 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:16771466,s0:2.0,s1:36.0,t:40,life:80,spin:-170,dy:10.0}
execute positioned ~ ~3 ~ run function ch:api/fx/orb {color:16771466,s:4.0,t:10,life:40}
particle minecraft:end_rod ~ ~6 ~ 12 4 12 0.02 200
playsound chaoshearts:speed_timefracture master @a[distance=..80] ~ ~ ~ 2 0.8
playsound minecraft:block.bell.resonate master @a[distance=..80] ~ ~ ~ 2 0.6
