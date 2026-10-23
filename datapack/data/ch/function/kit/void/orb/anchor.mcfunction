# The lifting orb anchors in place: a vertical gravity column appears below it.
playsound minecraft:block.beacon.activate player @a ~ ~ ~ 0.8 1.8
playsound chaoshearts:void_rift player @a ~ ~ ~ 0.8 0.8
execute positioned ~ ~-4 ~ rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:1310763,w:2.2,h:5.0,t:8,life:58}
execute rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:9059583,s0:0.5,s1:6.0,t:8,life:58,spin:170,dy:0.0}
