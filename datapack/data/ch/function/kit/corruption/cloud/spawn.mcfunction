# Spawns a plague cloud here from #crad (tenths), #clife (ticks), #camp (poison level) and #cwit (Wither II).
summon marker ~ ~ ~ {Tags:["ch.corruption.cloud","ch.corruption.cnew","ch.noability"]}
execute as @e[type=marker,tag=ch.corruption.cnew,limit=1] run function ch:kit/corruption/cloud/init
execute rotated 0 0 run function ch:api/fx/sprite {model:"cloud",color:8114490,s0:0.4,s1:3.0,t:6,life:40,spin:90,dy:0.4}
execute rotated 90 0 run function ch:api/fx/sprite {model:"cloud",color:4004434,s0:0.3,s1:2.2,t:8,life:36,spin:-90,dy:0.8}
execute positioned ~ ~-0.3 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:13161514,s0:0.5,s1:5.0,t:6,life:10,spin:120,dy:0.0}
