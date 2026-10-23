# Steps down until standing on solid ground, then erupts a slab there.
scoreboard players remove #ti_dd ch.tmp 1
execute if score #ti_dd ch.tmp matches ..0 run return fail
execute if block ~ ~ ~ #ch:passable unless block ~ ~-1 ~ #ch:passable run return run function ch:kit/titan/fx/slab_here
execute positioned ~ ~-1 ~ run function ch:kit/titan/fx/slab_seek
