# The cut: a wide crescent and a flash.
execute positioned ~ ~1.5 ~ rotated as @s rotated ~ 0 run function ch:api/fx/sprite {model:"slash",color:16771466,s0:0.6,s1:5.0,t:3,life:7,spin:150,dy:0.0}
execute positioned ~ ~1.5 ~ rotated as @s rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:0.3,s1:4.0,t:3,life:6,spin:0,dy:0.0}
particle minecraft:sweep_attack ~ ~1.3 ~ 1 0.3 1 0 5
particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~1 ~ 1 0.6 1 0 30
playsound minecraft:entity.player.attack.sweep master @a[distance=..40] ~ ~ ~ 1.5 1.3
playsound chaoshearts:speed_dash master @a[distance=..40] ~ ~ ~ 1.4 1
function ch:trials/speed/b/caster
execute as @a[tag=ch.challenger,distance=..3.2] run function ch:trials/speed/b/hit {d:80}
tag @s remove ch.caster
function ch:api/fx/shake {s:2,t:8,r:6}
