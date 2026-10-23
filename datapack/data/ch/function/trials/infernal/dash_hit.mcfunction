# Run down by the charge.
tag @s add ch.infernal.dh
function ch:trials/infernal/hit {d:90}
execute at @e[type=marker,tag=ch.infernal.tdash,limit=1,sort=nearest] run function ch:api/push {s:1.0,y:0.5}
function ch:api/fx/shake {s:3,t:8,r:3}
