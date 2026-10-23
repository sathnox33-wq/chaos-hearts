# Walks down from the leaper to the ground and marks where the slam will land (counterplay: get out of the circle).
scoreboard players remove #sd ch.tmp 1
execute unless block ~ ~-0.6 ~ #ch:passable run return run function ch:kit/rage/leap/mark
execute if score #sd ch.tmp matches 1.. positioned ~ ~-1 ~ run function ch:kit/rage/leap/seek
