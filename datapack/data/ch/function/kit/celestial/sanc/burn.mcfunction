# Radiant burn from Judgement.
execute store result score #ce_ok ch.tmp run function ch:kit/celestial/hit
execute unless score #ce_ok ch.tmp matches 1.. run return 0
function ch:api/cc {effect:"minecraft:slowness",sec:1,amp:0}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16763210,w:0.4,h:3.0,t:2,life:6}
