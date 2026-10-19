data modify storage ch:tmp dl.body append value {text:"",bold:true}
$data modify storage ch:tmp dl.body[-1].text set from storage ch:tmp m.a[$(n)].name
data modify storage ch:tmp dl.body[-1].color set from storage ch:tmp m.color
$function ch:menu/text {t:"   $(key)",c:"white"}
function ch:menu/text {t:"   cooldown ",c:"dark_gray"}
$function ch:menu/copy {p:"m.a[$(n)].cd",c:"dark_gray"}
function ch:menu/text {t:"s",c:"dark_gray"}
$execute store result score #u ch.tmp run data get storage ch:tmp m.a[$(n)].unlock
execute if score @s ch.lvl < #u ch.tmp run function ch:menu/text {t:"   🔒 mastery ",c:"red"}
$execute if score @s ch.lvl < #u ch.tmp run function ch:menu/copy {p:"m.a[$(n)].unlock",c:"red"}
function ch:menu/text {t:"\\n",c:"gray"}
$function ch:menu/copy {p:"m.a[$(n)].desc",c:"gray"}
$execute unless data storage ch:tmp m.a[$(n)]{var:""} run function ch:menu/text {t:"\\n",c:"gray"}
$execute unless data storage ch:tmp m.a[$(n)]{var:""} run function ch:menu/copy {p:"m.a[$(n)].var",c:"aqua"}
function ch:menu/text {t:"\\n\\n",c:"gray"}
