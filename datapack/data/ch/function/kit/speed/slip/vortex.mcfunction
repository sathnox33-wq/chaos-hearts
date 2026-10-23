# Vortex Lap, as the runner: a cyclone wall circles you and drags enemies into orbit.
execute if score #t4 ch.speed.g matches 0 run function ch:api/fx/ring {p:"minecraft:cloud",r:4.5}
execute if score #t4 ch.speed.g matches 2 positioned ~ ~1 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[0.96,0.88,0.26],scale:1.2}",r:3.8}
execute if score #t5 ch.speed.g matches 0 positioned ~ ~0.4 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:2741234,s0:7.0,s1:9.5,t:5,life:7,spin:170,dy:1.2}
execute if score #t10 ch.speed.g matches 0 run function ch:kit/speed/slip/vortex_pulse
