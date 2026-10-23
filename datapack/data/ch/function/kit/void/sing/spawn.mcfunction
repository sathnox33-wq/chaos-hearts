# Opens a singularity here: the controller marker and its display layers (core, accretion disk, halo, swirl).
summon marker ~ ~ ~ {Tags:["ch.void.sing","ch.void.snew","ch.noability"]}
execute as @e[type=marker,tag=ch.void.snew,limit=1] at @s run function ch:kit/void/sing/init
particle minecraft:reverse_portal ~ ~ ~ 0.5 0.5 0.5 0.6 80
execute rotated 0 0 run function ch:api/fx/sprite {model:"star",color:15259903,s0:0.2,s1:4.0,t:3,life:6,spin:150,dy:0.0}
