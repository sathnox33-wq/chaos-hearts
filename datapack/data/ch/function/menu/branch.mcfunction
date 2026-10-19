data modify storage ch:tmp dl.body append value {text:"",bold:true}
$data modify storage ch:tmp dl.body[-1].text set from storage ch:tmp m.br[$(b)].name
data modify storage ch:tmp dl.body[-1].color set from storage ch:tmp m.color
function ch:menu/text {t:"  ",c:"gray"}
$function ch:menu/copy {p:"m.br[$(b)].desc",c:"gray"}
function ch:menu/text {t:"\\n",c:"gray"}
$scoreboard players operation #n ch.tmp = @s $(s)
$function ch:menu/node {b:$(b),k:0}
$function ch:menu/node {b:$(b),k:1}
$function ch:menu/node {b:$(b),k:2}
$function ch:menu/node {b:$(b),k:3}
$function ch:menu/node {b:$(b),k:4}
function ch:menu/text {t:"\\n",c:"gray"}
$execute if score #n ch.tmp matches ..4 run function ch:menu/branch_button {b:$(b),c:$(c)}
