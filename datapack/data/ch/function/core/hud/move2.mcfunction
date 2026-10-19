data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud"}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.sp[$(i)]
