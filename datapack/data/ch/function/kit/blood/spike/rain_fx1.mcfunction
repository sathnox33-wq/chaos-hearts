# Crimson Rain impact pattern 1: spikes stabbing up out of the ground where the drops land.
execute positioned ~1.5 ~-0.5 ~0.6 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~1.5 ~3 ~0.6 0.05 1.5 0.05 0 6
execute positioned ~-1.8 ~-0.5 ~1.0 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~-1.8 ~3 ~1.0 0.05 1.5 0.05 0 6
execute positioned ~0.3 ~-0.5 ~-2.2 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~0.3 ~3 ~-2.2 0.05 1.5 0.05 0 6
execute positioned ~-0.6 ~-0.5 ~-0.4 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~-0.6 ~3 ~-0.4 0.05 1.5 0.05 0 6
execute positioned ~2.4 ~-0.5 ~-1.4 run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.7,1.6,0.7]",t:2,life:12,spin:45}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.2} ~2.4 ~3 ~-1.4 0.05 1.5 0.05 0 6
