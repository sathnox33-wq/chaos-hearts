# Internal: puts player $(pid)'s recorded name in the last body line.
$data modify storage ch:tmp dl.body[-1].text set from storage ch:data names[{pid:$(pid)}].name
