# A thread of blood from here toward the facing direction, #ln ch.tmp half-block steps.
scoreboard players remove #ln ch.tmp 1
particle minecraft:dust{color:[0.62,0.04,0.12],scale:0.8} ~ ~ ~ 0.02 0.02 0.02 0 1
execute if score #ln ch.tmp matches 1.. positioned ^ ^ ^0.5 run function ch:kit/blood/fx/line
