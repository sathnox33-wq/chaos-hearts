# Pact of Power.
execute unless score @s ch.b3 matches 2.. run effect give @s minecraft:strength 8 1
execute if score @s ch.b3 matches 2.. run effect give @s minecraft:strength 11 1
execute if score @s ch.b3 matches 4.. run effect give @s minecraft:speed 11 1
execute if score @s ch.b3 matches 4.. run effect give @s minecraft:haste 11 1
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16723263,s:2.4,t:3,life:7}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:10357535,s0:5.0,s1:0.6,t:6,life:8,spin:150,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:2818054,s0:0.5,s1:5.0,t:5,life:16,spin:-90,dy:0.0}
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.6} ~ ~1 ~ 0.8 0.9 0.8 0 50
function ch:api/fx/text {text:"PACT OF POWER",color:"#FF2D3F"}
return 1
