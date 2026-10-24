# Internal: draws the single mastery glyph $(k) in the heart's colour.
data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud_mb",shadow_color:0}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.mb.$(k)
data modify storage ch:tmp hud[-1].color set from storage ch:tmp n.col
function ch:core/hud/mb_back
