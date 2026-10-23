# The caster swallows a Siphon draught.
scoreboard players operation #dk ch.tmp = #sd2 ch.tmp
scoreboard players set #bk ch.tmp 0
execute if score @s ch.b1 matches 4.. run scoreboard players set #bk ch.tmp 1
function ch:kit/blood/drink
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:16723263,s0:1.6,s1:0.3,t:5,life:6,spin:170,dy:0.0}
