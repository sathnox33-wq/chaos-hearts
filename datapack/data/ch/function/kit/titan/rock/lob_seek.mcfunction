# Steps down to the ground, then marks the spot.
scoreboard players remove #ti_dd ch.tmp 1
execute if score #ti_dd ch.tmp matches ..0 run return run function ch:kit/titan/rock/lob_at
execute unless block ~ ~-1 ~ #ch:passable run return run function ch:kit/titan/rock/lob_at
execute positioned ~ ~-1 ~ run function ch:kit/titan/rock/lob_seek
