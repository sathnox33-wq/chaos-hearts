# One step of the tether.
scoreboard players remove #cls ch.tmp 1
particle minecraft:dust{color:[0.482,0.82,0.227],scale:0.8} ~ ~ ~ 0.02 0.02 0.02 0 1
execute if score #cls ch.tmp matches 1.. unless entity @a[tag=ch.caster,distance=..1.2] positioned ^ ^ ^0.5 run function ch:kit/corruption/inf/tline
