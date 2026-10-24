# Internal: appends digit glyph $(c) in white, then steps the pen back.
data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud_mb",shadow_color:0,color:"#FFFFFF"}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.mb.digit[$(c)]
function ch:core/hud/mb_back
