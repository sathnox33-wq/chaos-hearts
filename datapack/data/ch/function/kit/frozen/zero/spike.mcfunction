# An ice spike tears out of the ground: 5 damage and a toss into the air.
function ch:api/fx/sprite3 {model:"spike",color:10217471,a:"[0.9,0.2,0.9]",b:"[1.3,3.8,1.3]",t:3,life:24,spin:40}
execute rotated 40 0 positioned ~0.4 ~ ~0.2 run function ch:api/fx/sprite3 {model:"spike",color:15924223,a:"[0.5,0.2,0.5]",b:"[0.7,2.2,0.7]",t:3,life:22,spin:-30}
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:6273256,s0:1.0,s1:3.2,t:3,life:24,spin:0,dy:0.0}
particle minecraft:block{block_state:"minecraft:blue_ice"} ~ ~0.5 ~ 0.4 0.8 0.4 0.15 30
playsound minecraft:block.glass.break player @a ~ ~ ~ 1 0.5
playsound minecraft:block.pointed_dripstone.land player @a ~ ~ ~ 1 0.6
scoreboard players set #f_dmg ch.tmp 50
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.7] run function ch:kit/frozen/zero/spike_one
