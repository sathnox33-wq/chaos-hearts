# The boss wandered (or teleported) too far: the void drags it back to the centre of the island.
particle minecraft:reverse_portal ~ ~2 ~ 0.5 1 0.5 0.2 40
execute at @e[type=marker,tag=ch.session,limit=1,sort=nearest] run tp @s ~ ~1 ~
execute at @s run function ch:trials/void/spawn_fx
