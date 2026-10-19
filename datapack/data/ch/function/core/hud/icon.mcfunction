data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud",shadow_color:0}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.ab[$(c)]
$data modify storage ch:tmp hud[-1].color set value "$(col)"
scoreboard players add #adv ch.tmp 17
