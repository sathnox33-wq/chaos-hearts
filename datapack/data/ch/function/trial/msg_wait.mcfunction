scoreboard players add #wait ch.tmp 1199
scoreboard players operation #wait ch.tmp /= #1200 ch.g
execute store result storage ch:tmp n.v int 1 run scoreboard players get #wait ch.tmp
function ch:trial/msg_wait2 with storage ch:tmp n
