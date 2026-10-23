# Crimson Rain impact pattern 2: spikes stabbing up out of the ground where the drops land.
execute positioned ~-1.2 ~-0.5 ~1.9 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~-1.2 ~3 ~1.9 0.05 1.5 0.05 0 6
execute positioned ~1.9 ~-0.5 ~1.8 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~1.9 ~3 ~1.8 0.05 1.5 0.05 0 6
execute positioned ~-2.5 ~-0.5 ~-1.2 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~-2.5 ~3 ~-1.2 0.05 1.5 0.05 0 6
execute positioned ~0.9 ~-0.5 ~-0.8 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~0.9 ~3 ~-0.8 0.05 1.5 0.05 0 6
execute positioned ~0 ~-0.5 ~0.4 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~0 ~3 ~0.4 0.05 1.5 0.05 0 6
