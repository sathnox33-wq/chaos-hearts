data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud_meter",shadow_color:0}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.mt[$(c)]
$data modify storage ch:tmp hud[-1].color set value "$(col)"
scoreboard players add #adv ch.tmp 75
