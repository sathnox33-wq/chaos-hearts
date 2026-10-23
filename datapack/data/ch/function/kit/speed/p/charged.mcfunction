# Momentum is full: the air around you starts to crackle.
playsound minecraft:block.amethyst_block.chime player @a ~ ~ ~ 1 2
playsound minecraft:block.note_block.chime player @s ~ ~ ~ 0.7 2
particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~1 ~ 0.3 0.5 0.3 0 14
particle minecraft:electric_spark ~ ~1 ~ 0.3 0.5 0.3 0.2 12
execute positioned ~ ~0.1 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"ring",color:16113986,s0:0.3,s1:2.6,t:4,life:8,spin:160,dy:0.0}
execute positioned ~ ~1 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"bolt",color:16771466,s0:0.2,s1:1.1,t:3,life:6,spin:90,dy:0.8}
function ch:api/fx/screen {o:"speed",color:"#F5E142",in:1,stay:2,out:8}
