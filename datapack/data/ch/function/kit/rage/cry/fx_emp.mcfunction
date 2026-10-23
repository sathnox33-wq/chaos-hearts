# Empowered War Cry: Fury burns out of you in a crimson pillar.
function ch:api/fx/pillar {model:"beam",color:14689835,w:1.2,h:8.0,t:3,life:10}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:14689835,s0:1.0,s1:8.0,t:3,life:30,spin:0,dy:0.0}
particle minecraft:flame ~ ~1 ~ 1 1 1 0.1 40
function ch:api/fx/text {text:"FURY SPENT",color:"#FF6A1F"}
playsound minecraft:item.firecharge.use player @a ~ ~ ~ 1 0.5
