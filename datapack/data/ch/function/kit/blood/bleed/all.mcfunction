# Runs every bleeding entity (only while any bleed exists).
scoreboard players set #bleeds ch.blood.g 0
execute as @e[scores={ch.blood.bleed=1..}] at @s run function ch:kit/blood/bleed/tick
