# Draws overlay glyph $(g) on the icon just drawn and moves past the slot gap.
data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud",shadow_color:0}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.$(g)
scoreboard players add #adv ch.tmp 17
scoreboard players set #dx ch.tmp 1
function ch:core/hud/move
