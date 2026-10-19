scoreboard players set #dx ch.tmp -9
function ch:core/hud/move
scoreboard players operation #d ch.tmp = #sec ch.tmp
scoreboard players operation #d ch.tmp /= #10 ch.g
execute store result storage ch:tmp n.c int 1 run scoreboard players get #d ch.tmp
function ch:core/hud/digit with storage ch:tmp n
scoreboard players operation #d ch.tmp = #sec ch.tmp
scoreboard players operation #d ch.tmp %= #10 ch.g
execute store result storage ch:tmp n.c int 1 run scoreboard players get #d ch.tmp
function ch:core/hud/digit with storage ch:tmp n
