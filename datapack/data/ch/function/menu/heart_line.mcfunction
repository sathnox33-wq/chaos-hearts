# One line of the hearts list for heart $(h) (index $(i)).
$scoreboard players set #i ch.tmp $(i)
function ch:gen/describe
data modify storage ch:tmp dl.body append value {text:"❤ ",bold:true}
data modify storage ch:tmp dl.body[-1].color set from storage ch:tmp h.color
data modify storage ch:tmp dl.body append value {text:"",bold:true}
data modify storage ch:tmp dl.body[-1].text set from storage ch:tmp h.title
data modify storage ch:tmp dl.body[-1].color set from storage ch:tmp h.color
function ch:menu/text {t:"   mastery ",c:"gray"}
$function ch:menu/score {o:"ch.lvl.$(h)",c:"white"}
$execute if score @s ch.cnt.$(h) matches 2.. run function ch:menu/text {t:"   x",c:"gray"}
$execute if score @s ch.cnt.$(h) matches 2.. run function ch:menu/score {o:"ch.cnt.$(h)",c:"gray"}
$execute if score @s ch.awk.$(h) matches 1 run function ch:menu/text {t:"   ✦ awakened",c:"gold"}
$execute if score @s ch.active matches $(i) run function ch:menu/text {t:"   ◆ active",c:"aqua"}
function ch:menu/text {t:"\\n",c:"gray"}
