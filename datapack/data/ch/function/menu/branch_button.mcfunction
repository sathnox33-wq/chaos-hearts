$data modify storage ch:tmp dl.actions append value {label:{text:""},action:{type:"minecraft:run_command",command:"trigger chmenu set $(c)"}}
$data modify storage ch:tmp dl.actions[-1].label.text set from storage ch:tmp m.br[$(b)].name
