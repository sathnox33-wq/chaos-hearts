# Lightspeed (awakened): sprinting leaves a crackling electric trail.
particle minecraft:electric_spark ~ ~0.2 ~ 0.2 0.05 0.2 0.02 3
particle minecraft:dust{color:[0.16,0.83,0.95],scale:0.7} ~ ~0.5 ~ 0.1 0.2 0.1 0 2
execute if score #t10 ch.speed.g matches 0 positioned ~ ~0.05 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"bolt",color:2741234,s0:0.4,s1:0.9,t:3,life:6,spin:170,dy:0.0}
