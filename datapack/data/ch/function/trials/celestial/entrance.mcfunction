# Astrael falls from the firmament.
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:3.0,h:30.0,t:4,life:30}
execute positioned ~ ~1.5 ~ run function ch:api/fx/orb {color:16773808,s:8.0,t:4,life:10}
function ch:api/fx/wave {color:16765803,r:12,t:12}
particle minecraft:end_rod ~ ~1.5 ~ 0.5 0.5 0.5 0.4 150
particle minecraft:firework ~ ~1.5 ~ 1 1 1 0.3 60
playsound minecraft:block.beacon.activate master @a ~ ~ ~ 3 0.6
playsound chaoshearts:celestial_chime master @a ~ ~ ~ 2 0.7
playsound chaoshearts:celestial_ascension master @a ~ ~ ~ 2 0.8
