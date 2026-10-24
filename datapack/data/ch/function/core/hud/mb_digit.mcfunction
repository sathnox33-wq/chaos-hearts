# Internal: draws digit glyph #d ch.tmp.
execute store result storage ch:tmp n.c int 1 run scoreboard players get #d ch.tmp
function ch:core/hud/mb_draw with storage ch:tmp n
