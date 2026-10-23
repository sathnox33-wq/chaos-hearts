# Tripped mine: violent pull within 6 blocks.
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6,limit=12] run function ch:kit/void/orb/grab
particle minecraft:portal ~ ~ ~ 0 0 0 3 40
particle minecraft:dust{color:[0.039,0.0,0.078],scale:2.0} ~ ~ ~ 0.4 0.4 0.4 0 6
