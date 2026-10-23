# Afterimage sprites (meteors leave a tail of flame).
$execute unless score @s ch.v4 matches 1 run function ch:api/fx/sprite {model:"orb",color:$(c),s0:0.55,s1:0.05,t:5,life:6,spin:0,dy:0.0}
$execute if score @s ch.v4 matches 1 run function ch:api/fx/sprite {model:"orb",color:$(c2),s0:1.4,s1:0.1,t:6,life:7,spin:0,dy:0.0}
$execute if score @s ch.v4 matches 1 run function ch:api/fx/sprite {model:"flame",color:$(c),s0:1.2,s1:0.2,t:6,life:7,spin:160,dy:0.6}
