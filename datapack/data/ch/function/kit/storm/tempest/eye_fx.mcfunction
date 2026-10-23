# The eye's funnel and its turning wall of cloud.
$execute rotated as @s positioned ^ ^1 ^$(r) run particle minecraft:cloud ~ ~ ~ 0.3 1 0.3 0.02 6
$execute rotated as @s rotated ~120 0 positioned ^ ^2 ^$(r) run particle minecraft:cloud ~ ~ ~ 0.3 1 0.3 0.02 6
$execute rotated as @s rotated ~240 0 positioned ^ ^1.5 ^$(r) run particle minecraft:cloud ~ ~ ~ 0.3 1 0.3 0.02 6
$execute rotated as @s rotated ~60 0 positioned ^ ^0.3 ^$(r) run particle minecraft:dust{color:[0.31,0.66,1.0],scale:1.3} ~ ~ ~ 0.2 0.2 0.2 0 3
$execute positioned ~ ~8 ~ run particle minecraft:dust{color:[0.25,0.28,0.36],scale:3.0} ~ ~ ~ $(r) 0.4 $(r) 0 10
execute positioned ~ ~0.4 ~ rotated as @s run function ch:api/fx/sprite {model:"swirl",color:15267583,s0:3.0,s1:3.5,t:2,life:3,spin:170,dy:0.0}
execute positioned ~ ~4 ~ rotated as @s run function ch:api/fx/sprite {model:"swirl",color:5220607,s0:6.0,s1:7.0,t:2,life:3,spin:-170,dy:0.0}
