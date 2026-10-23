# Walks down to the ground (up to 10 blocks) and runs the function in storage ch:corruption g there.
scoreboard players remove #cgr ch.tmp 1
execute if score #cgr ch.tmp matches 1.. if block ~ ~-0.6 ~ #ch:passable positioned ~ ~-1 ~ run return run function ch:kit/corruption/ground
execute align y run function ch:kit/corruption/ground_run with storage ch:corruption g
