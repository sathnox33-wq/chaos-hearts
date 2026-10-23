# Walks down to the ground for Moonfall.
scoreboard players remove #sd ch.tmp 1
execute unless block ~ ~-0.6 ~ #ch:passable align y positioned ~ ~0.01 ~ run return run function ch:kit/blood/moon/fall_mark
execute if score #sd ch.tmp matches 1.. positioned ~ ~-1 ~ run function ch:kit/blood/moon/fall_seek
