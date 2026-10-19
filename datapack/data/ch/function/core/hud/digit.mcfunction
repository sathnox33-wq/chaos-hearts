data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud_num",shadow_color:0}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.dg[$(c)]
scoreboard players add #adv ch.tmp 4
