# Void became active: the heart opens with a fold of space.
scoreboard players set @s ch.meter 0
playsound chaoshearts:void_rift player @a ~ ~ ~ 0.6 1.4
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.6 0.3 0.1 40
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:2.5,s1:0.2,t:8,life:10,spin:160,dy:0.0}
