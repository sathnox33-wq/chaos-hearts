# Internal: appends glyph $(c) of mastery part $(k) in colour $(w), then steps the pen back.
data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud_mb",shadow_color:0}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.mb.$(k)[$(c)]
$data modify storage ch:tmp hud[-1].color set value "$(w)"
function ch:core/hud/mb_back
