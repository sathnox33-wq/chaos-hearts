# Ice Prison: a shell of real ice around (never inside) the target for 2 seconds.
scoreboard players set #f_dl ch.tmp 1
scoreboard players set #f_dur ch.tmp 40
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~1 ~ ~ run function ch:kit/frozen/wall/new
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~-1 ~ ~ run function ch:kit/frozen/wall/new
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~ ~ ~1 run function ch:kit/frozen/wall/new
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~ ~ ~-1 run function ch:kit/frozen/wall/new
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~1 ~1 ~ run function ch:kit/frozen/wall/new
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~-1 ~1 ~ run function ch:kit/frozen/wall/new
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~ ~1 ~1 run function ch:kit/frozen/wall/new
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~ ~1 ~-1 run function ch:kit/frozen/wall/new
execute align xyz positioned ~0.5 ~ ~0.5 positioned ~ ~2 ~ run function ch:kit/frozen/wall/new
