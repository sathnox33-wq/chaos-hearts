# First time this orb catches this enemy: Gravity Well count (and a lifting orb floats players).
scoreboard players operation @s ch.void.oid = #oid ch.tmp
scoreboard players add @e[type=item_display,tag=ch.void.cur,limit=1] ch.v3 1
particle minecraft:reverse_portal ~ ~ ~ 0.2 0.2 0.2 0.3 10
execute if entity @s[type=player] if score @e[type=item_display,tag=ch.void.cur,limit=1] ch.v1 matches 1 run function ch:api/cc {effect:"minecraft:levitation",sec:2,amp:0}
