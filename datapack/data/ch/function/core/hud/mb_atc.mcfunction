# Internal: draws glyph #c ch.tmp of the mastery part $(k) in the heart's colour.
execute store result storage ch:tmp n.c int 1 run scoreboard players get #c ch.tmp
$data modify storage ch:tmp n.k set value "$(k)"
data modify storage ch:tmp n.w set from storage ch:tmp n.col
function ch:core/hud/mb_drawi with storage ch:tmp n
