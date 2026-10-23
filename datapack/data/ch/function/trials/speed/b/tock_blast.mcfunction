# The bell strikes.
function ch:api/fx/pillar {model:"beam",color:16771466,w:5.0,h:6.0,t:2,life:8}
function ch:api/fx/wave {color:16113986,r:4.0,t:5}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16771466,s:6.0,t:3,life:6}
particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~1 ~ 1.5 1 1.5 0 60
particle minecraft:explosion ~ ~1 ~ 1 0.3 1 0 4
playsound minecraft:block.bell.use master @a[distance=..60] ~ ~ ~ 2 1.5
playsound minecraft:block.bell.resonate master @a[distance=..60] ~ ~ ~ 1.5 1
execute as @e[tag=ch.boss,distance=..90,limit=1] run function ch:trials/speed/b/caster
execute as @a[tag=ch.challenger,distance=..3.4] run function ch:trials/speed/b/hit {d:100}
tag @e[tag=ch.boss,distance=..90] remove ch.caster
function ch:api/fx/shake {s:3,t:10,r:10}
kill @s
