scoreboard players set #dx ch.tmp -5
function ch:core/hud/move
execute store result storage ch:tmp n.c int 1 run scoreboard players get #sec ch.tmp
function ch:core/hud/digit with storage ch:tmp n
