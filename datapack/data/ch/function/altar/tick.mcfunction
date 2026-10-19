# Animates altars that have a player nearby: spinning crystal and rune, orbiting heart gems, sparks and a low hum.
scoreboard players operation #a40 ch.tmp = #now ch.g
scoreboard players operation #a40 ch.tmp %= #40 ch.g
execute if score #a40 ch.tmp matches 0 as @e[type=marker,tag=ch.altar] at @s if entity @a[distance=..48,limit=1] run function ch:altar/animate
execute if score #t20 ch.g matches 0 as @e[type=marker,tag=ch.altar] at @s if entity @a[distance=..32,limit=1] run function ch:altar/sparks
execute if score #t20 ch.g matches 10 as @e[type=marker,tag=ch.altar] at @s if entity @a[distance=..32,limit=1] run function ch:altar/sparks
