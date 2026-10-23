# Void world tick: rift orbs, singularities and awakened rifts.
execute if entity @e[type=item_display,tag=ch.void.orb,limit=1] as @e[type=item_display,tag=ch.void.orb] at @s run function ch:kit/void/orb/tick
execute if entity @e[type=marker,tag=ch.void.sing,limit=1] as @e[type=marker,tag=ch.void.sing] at @s run function ch:kit/void/sing/tick
execute if entity @e[type=marker,tag=ch.void.rift,limit=1] as @e[type=marker,tag=ch.void.rift] at @s run function ch:kit/void/step/rift_tick
