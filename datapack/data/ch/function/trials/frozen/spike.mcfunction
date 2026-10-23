# An ice spike erupts: 7 damage, slow and a toss.
function ch:api/fx/sprite3 {model:"spike",color:10217471,a:"[1.0,0.2,1.0]",b:"[1.5,4.2,1.5]",t:3,life:26,spin:40}
execute rotated 50 0 positioned ~0.4 ~ ~-0.3 run function ch:api/fx/sprite3 {model:"spike",color:15924223,a:"[0.5,0.2,0.5]",b:"[0.8,2.6,0.8]",t:3,life:24,spin:-40}
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:6273256,s0:1.0,s1:3.6,t:3,life:30,spin:0,dy:0.0}
particle minecraft:block{block_state:"minecraft:packed_ice"} ~ ~0.5 ~ 0.4 0.8 0.4 0.15 30
playsound minecraft:block.glass.break master @a[distance=..40] ~ ~ ~ 1 0.6
playsound minecraft:block.pointed_dripstone.land master @a[distance=..40] ~ ~ ~ 1 0.6
execute positioned ~ ~1 ~ as @a[tag=ch.challenger,distance=..1.9] at @s run function ch:trials/frozen/spike_hit
