# A crackling violet thread from the caster's eyes to the target.
scoreboard players remove #vls ch.tmp 1
particle minecraft:dust{color:[0.541,0.235,1.0],scale:1.0} ~ ~ ~ 0.04 0.04 0.04 0 2
particle minecraft:dust{color:[0.039,0.0,0.078],scale:1.4} ~ ~ ~ 0.08 0.08 0.08 0 1
particle minecraft:reverse_portal ~ ~ ~ 0 0 0 0.03 1
execute if score #vls ch.tmp matches 1.. unless entity @e[tag=ch.void.dt,distance=..1.2] positioned ^ ^ ^0.5 run function ch:kit/void/disp/line
