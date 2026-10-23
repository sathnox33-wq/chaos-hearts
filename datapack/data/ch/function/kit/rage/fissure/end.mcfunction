# The fissure's last tear: an eruption at its tip.
execute positioned ~ ~0.1 ~ run function ch:api/fx/pillar {model:"flame",color:16738847,w:2.0,h:4.0,t:3,life:9}
function ch:api/fx/wave {color:3801088,r:2.5,t:5}
particle minecraft:explosion ~ ~0.5 ~ 0.4 0.2 0.4 0 2
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.8 0.8
kill @s
