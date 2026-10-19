$data modify storage ch:tmp hud append value {text:"",font:"chaoshearts:hud_r$(r)",shadow_color:0}
$data modify storage ch:tmp hud[-1].text set from storage ch:const hud.hg[$(c)]
scoreboard players add #adv ch.tmp 10
scoreboard players set #dx ch.tmp -2
function ch:core/hud/move
