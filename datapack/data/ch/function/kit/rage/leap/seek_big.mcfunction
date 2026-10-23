# Finds the ground under the apex and paints the big impact sigil.
scoreboard players remove #sd ch.tmp 1
execute unless block ~ ~-0.6 ~ #ch:passable run return run function ch:kit/rage/leap/sigil
execute if score #sd ch.tmp matches 1.. positioned ~ ~-1 ~ run function ch:kit/rage/leap/seek_big
