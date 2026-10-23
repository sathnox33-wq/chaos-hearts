# Walks down to the ground for Crimson Rain.
scoreboard players remove #sd ch.tmp 1
execute unless block ~ ~-0.6 ~ #ch:passable align y run return run function ch:kit/blood/spike/rain_mark
execute if score #sd ch.tmp matches 1.. positioned ~ ~-1 ~ run function ch:kit/blood/spike/rain_seek
execute if score #sd ch.tmp matches ..0 run function ch:kit/blood/spike/rain_mark
