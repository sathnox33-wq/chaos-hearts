# One step of the leaping infection.
scoreboard players remove #cls ch.tmp 1
particle minecraft:dust{color:[0.643,1.0,0.31],scale:1.3} ~ ~ ~ 0.05 0.05 0.05 0 3
particle minecraft:sculk_soul ~ ~ ~ 0 0 0 0.01 1
execute if score #cls ch.tmp matches 1.. unless entity @e[tag=ch.corruption.jt,distance=..1.2] positioned ^ ^ ^0.5 run function ch:kit/corruption/inf/jstep
