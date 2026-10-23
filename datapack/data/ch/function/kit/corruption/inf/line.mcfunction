# A writhing green thread from the caster to the host.
scoreboard players remove #cls ch.tmp 1
particle minecraft:dust{color:[0.643,1.0,0.31],scale:1.0} ~ ~ ~ 0.05 0.05 0.05 0 2
particle minecraft:dust{color:[0.239,0.102,0.322],scale:1.3} ~ ~ ~ 0.1 0.1 0.1 0 1
execute if score #cls ch.tmp matches 1.. unless entity @e[tag=ch.target,distance=..1.2] positioned ^ ^ ^0.5 run function ch:kit/corruption/inf/line
