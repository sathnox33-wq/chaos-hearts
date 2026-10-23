# Phase: every incoming projectile near you rolls once (15%, 30% with Slippery Space) to pass straight through you.
tag @s add ch.void.me
execute as @e[type=#minecraft:arrows,distance=..6,tag=!ch.void.rolled] run function ch:kit/void/phase/roll
execute as @e[type=trident,distance=..6,tag=!ch.void.rolled] run function ch:kit/void/phase/roll
execute as @e[type=item_display,tag=ch.proj,distance=..4,tag=!ch.void.rolled] run function ch:kit/void/phase/roll
execute as @e[type=small_fireball,distance=..4,tag=!ch.void.rolled] run function ch:kit/void/phase/roll
execute as @e[type=shulker_bullet,distance=..3,tag=!ch.void.rolled] run function ch:kit/void/phase/roll
tag @s remove ch.void.me
