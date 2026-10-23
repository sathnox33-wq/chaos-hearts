# Finds the ground within a few blocks of here and heaves a slab of it up.
scoreboard players set #ti_dd ch.tmp 7
execute positioned ~ ~2 ~ run function ch:kit/titan/fx/slab_seek
