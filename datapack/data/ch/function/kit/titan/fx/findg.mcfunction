# Marches down from here (up to 24 blocks) and draws the landing ring on the ground (#ti_r: 0 small, 1 large).
scoreboard players remove #ti_dd ch.tmp 1
execute if score #ti_dd ch.tmp matches ..0 run return fail
execute unless block ~ ~-1 ~ #ch:passable run return run function ch:kit/titan/fx/landmark
execute positioned ~ ~-1 ~ run function ch:kit/titan/fx/findg
