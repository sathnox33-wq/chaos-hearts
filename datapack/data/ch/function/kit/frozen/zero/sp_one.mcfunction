# Shattered.
tag @s remove ch.frozen.sp
function ch:kit/frozen/hurt
execute if entity @s[tag=ch.frozen.solid] run function ch:kit/frozen/shatter
particle minecraft:block{block_state:"minecraft:blue_ice"} ~ ~1 ~ 0.5 0.8 0.5 0.3 50
function ch:api/fx/sprite {model:"star",color:15924223,s0:0.5,s1:4.0,t:3,life:7,spin:170,dy:0.5}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"shatter",color:"#F2FBFF",in:0,stay:5,out:14}
