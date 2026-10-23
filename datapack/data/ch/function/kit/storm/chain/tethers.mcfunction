# Drives every Arc Snare tether.
scoreboard players set #teth ch.storm.g 0
execute as @e[scores={ch.storm.teth=1..}] at @s run function ch:kit/storm/chain/tether
