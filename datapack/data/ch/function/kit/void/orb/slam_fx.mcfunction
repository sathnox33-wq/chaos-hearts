# The slam: a black beam drives down from the orb.
execute positioned ~ ~-5 ~ rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:655380,w:3.0,h:5.5,t:2,life:8}
execute positioned ~ ~-4 ~ run function ch:api/fx/wave {color:9059583,r:6.0,t:6}
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1 0.7
