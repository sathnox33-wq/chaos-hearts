# Counts down Ionized marks.
scoreboard players set #ion ch.storm.g 0
execute as @e[scores={ch.storm.ion=1..}] at @s run function ch:kit/storm/fn/ion_one
