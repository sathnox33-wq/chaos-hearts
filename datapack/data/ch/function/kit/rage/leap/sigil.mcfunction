# The Skyfall impact sigil: a hex and a spinning rune growing on the ground, a beam of warning light to the sky.
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:14689835,s0:1.0,s1:12.0,t:8,life:22,spin:60,dy:0.0}
execute positioned ~ ~0.12 ~ rotated 45 0 run function ch:api/fx/sprite {model:"rune",color:16738847,s0:0.5,s1:8.0,t:8,life:22,spin:-120,dy:0.0}
function ch:api/fx/pillar {model:"beam",color:14689835,w:0.35,h:16.0,t:6,life:20}
particle minecraft:dust{color:[0.88,0.15,0.17],scale:2.5} ~ ~0.3 ~ 2.5 0.05 2.5 0 40
