# Each second: every enemy within 10 bleeds for 1.5 s (a Blood Moon bleed).
tag @s add ch.caster
scoreboard players set #bt ch.tmp 30
scoreboard players set #bm ch.tmp 1
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..10] run function ch:kit/blood/moon/bleed_one
tag @s remove ch.caster
