# Steps down from here to the ground (up to #ce_dd blocks), then calls the star.
scoreboard players remove #ce_dd ch.tmp 1
execute if score #ce_dd ch.tmp matches ..0 run return run function ch:kit/celestial/star/call
execute unless block ~ ~-1 ~ #ch:passable run return run function ch:kit/celestial/star/call
execute positioned ~ ~-1 ~ run function ch:kit/celestial/star/ground
