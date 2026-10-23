# Counts down every entity with a primed sonic boom (Momentum, Shade Ambush).
scoreboard players set #boom ch.speed.g 0
execute as @e[scores={ch.speed.boom=1..}] at @s run function ch:kit/speed/boom/tick
