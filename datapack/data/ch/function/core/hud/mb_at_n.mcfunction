# Internal: draws digit glyph $(c).
$data modify storage ch:tmp n.c set value $(c)
data modify storage ch:tmp n.k set value "digit"
data modify storage ch:tmp n.w set value "#FFFFFF"
function ch:core/hud/mb_drawi with storage ch:tmp n
