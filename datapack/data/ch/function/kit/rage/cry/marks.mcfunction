# Keeps Challenge marks: a crimson brand over each marked enemy until it expires.
scoreboard players set #rmk ch.rage.g 0
execute as @e[tag=ch.rage.marked] at @s run function ch:kit/rage/cry/mark_tick
