# Titan holder hit something: Tremor builds, and as a Colossus every blow sends out a shockwave.
scoreboard players add @s ch.titan.trem 4
scoreboard players operation @s ch.titan.lt = #now ch.g
execute if score @s ch.titan.col matches 1.. as @e[tag=ch.victim,limit=1] at @s run function ch:kit/titan/col/blow
