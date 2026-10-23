# One hellgate.
summon minecraft:marker ~ ~ ~ {Tags:["ch.tmob","ch.noability","ch.infernal.tgate","ch.infernal.gnew"]}
scoreboard players set @e[type=marker,tag=ch.infernal.gnew,limit=1] ch.life 300
tag @e[type=marker,tag=ch.infernal.gnew] remove ch.infernal.gnew
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:16742938,s0:0.5,s1:6.0,t:10,life:300,spin:0,dy:0.0}
execute rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"rune",color:9182208,s0:0.5,s1:5.5,t:10,life:300,spin:170,dy:0.0}
function ch:api/fx/pillar {model:"flame",color:16742938,w:3.0,h:5.0,t:5,life:12}
particle minecraft:lava ~ ~0.3 ~ 1 0.2 1 0 20
