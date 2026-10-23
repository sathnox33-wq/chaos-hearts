# Vael folds out of time.
effect give @s minecraft:invisibility 1 0 true
particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~1.3 ~ 0.4 0.8 0.4 0 40
particle minecraft:cloud ~ ~1 ~ 0.4 0.6 0.4 0.05 20
execute positioned ~ ~1.3 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:16113986,s0:3.0,s1:0.1,t:5,life:7,spin:0,dy:0.0}
playsound minecraft:entity.enderman.teleport master @a[distance=..60] ~ ~ ~ 1 1.8
