# A mob tears in out of a rift.
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.8 0.3 0.2 50
particle minecraft:dust{color:[0.039,0.0,0.078],scale:2.0} ~ ~1 ~ 0.4 0.8 0.4 0 20
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"rune",color:9059583,s0:0.3,s1:3.0,t:6,life:14,spin:170,dy:0.0}
playsound minecraft:entity.enderman.teleport hostile @a ~ ~ ~ 1 0.6
