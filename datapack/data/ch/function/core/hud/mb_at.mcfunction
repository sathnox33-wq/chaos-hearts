# Internal: draws glyph #c ch.tmp of the mastery part $(k) in colour $(col).
execute store result storage ch:tmp n.c int 1 run scoreboard players get #c ch.tmp
$data modify storage ch:tmp n.k set value "$(k)"
$data modify storage ch:tmp n.w set value "$(col)"
function ch:core/hud/mb_drawi with storage ch:tmp n
