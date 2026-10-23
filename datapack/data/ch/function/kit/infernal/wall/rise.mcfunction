# A segment erupts out of the ground.
$function ch:api/fx/pillar {model:"flame",color:$(c),w:1.1,h:3.2,t:5,life:12}
$execute unless score @s ch.v2 matches 1.. rotated 0 0 positioned ~ ~0.05 ~ run function ch:api/fx/sprite {model:"crack",color:$(c2),s0:0.6,s1:1.8,t:6,life:$(dur),spin:0,dy:0.0}
$particle $(fl) ~ ~0.5 ~ 0.2 0.6 0.2 0.08 10
particle minecraft:lava ~ ~0.3 ~ 0.2 0.1 0.2 0 2
