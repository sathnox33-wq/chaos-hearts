# A 3-high ice column: blocks appear bottom to top after #f_cd ticks and last #f_dur.
scoreboard players operation #f_dl ch.tmp = #f_cd ch.tmp
scoreboard players add #f_dl ch.tmp 1
function ch:kit/frozen/wall/new
scoreboard players add #f_dl ch.tmp 2
execute positioned ~ ~1 ~ run function ch:kit/frozen/wall/new
scoreboard players add #f_dl ch.tmp 2
execute positioned ~ ~2 ~ run function ch:kit/frozen/wall/new
