# One key label (17 pixels plus 1 of advance), so the next one starts under the next icon.
data modify storage ch:tmp n.col set value "#ECE4F4"
$execute if score @s ch.cd$(s) matches 1.. run data modify storage ch:tmp n.col set value "#8A8496"
$execute if score @s ch.lvl < #unlock$(s) ch.g run data modify storage ch:tmp n.col set value "#4A4652"
$data modify storage ch:tmp n.c set value $(s)
function ch:core/hud/key_put with storage ch:tmp n
