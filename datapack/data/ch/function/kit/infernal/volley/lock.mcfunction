# Seeking Flame: remembers the enemy under the crosshair (32 blocks); the volley curves toward it.
function ch:api/ray {range:32}
execute if score #rayhit ch.tmp matches 1 as @e[tag=ch.target,limit=1] at @s run function ch:kit/infernal/volley/lock2
execute if score #rayhit ch.tmp matches 1 as @e[tag=ch.target,limit=1] at @s run function ch:api/fx/sprite {model:"hex",color:14692378,s0:2.5,s1:0.9,t:5,life:12,spin:170,dy:0.0}
tag @e[tag=ch.target] remove ch.target
