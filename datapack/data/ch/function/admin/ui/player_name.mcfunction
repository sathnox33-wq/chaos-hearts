# Internal: puts player $(pid)'s recorded name on the last button.
$data modify storage ch:tmp dl.actions[-1].label.text set from storage ch:data names[{pid:$(pid)}].name
