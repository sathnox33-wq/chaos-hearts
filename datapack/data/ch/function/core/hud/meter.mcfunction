# The heart's resource meter (ch.meter 0..100) in its colour.
function ch:core/hud/goto {x:-37}
scoreboard players operation #c ch.tmp = @s ch.meter
execute if score #c ch.tmp matches 101.. run scoreboard players set #c ch.tmp 100
scoreboard players operation #c ch.tmp /= #5 ch.g
execute store result storage ch:tmp n.c int 1 run scoreboard players get #c ch.tmp
data modify storage ch:tmp n.col set from storage ch:tmp h.color
function ch:core/hud/meter2 with storage ch:tmp n
