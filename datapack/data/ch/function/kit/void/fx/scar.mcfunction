# Later at the origin: the tear in space lingers a moment, spitting sparks, then seals.
particle minecraft:end_rod ~ ~ ~ 0.1 0.5 0.1 0.04 8
particle minecraft:reverse_portal ~ ~ ~ 0.1 0.6 0.1 0.03 12
execute rotated ~ 90 run function ch:api/fx/sprite3 {model:"shard",color:13864191,a:"[0.1,1.6,0.1]",b:"[0.02,2.4,0.02]",t:10,life:12,spin:0}
execute rotated 0 0 run function ch:api/fx/sprite3 {model:"beam",color:1310763,a:"[0.25,0.1,0.25]",b:"[0.05,2.2,0.05]",t:8,life:12,spin:170}
playsound minecraft:block.respawn_anchor.deplete player @a ~ ~ ~ 0.4 1.8
