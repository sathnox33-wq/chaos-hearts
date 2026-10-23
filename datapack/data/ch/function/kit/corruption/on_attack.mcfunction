# Corruption melee: Blight (mastery 25) - poison that grows stronger with repeated hits on the same enemy.
execute if score @s ch.lvl matches 25.. as @e[tag=ch.victim,limit=1] at @s run function ch:kit/corruption/blight
