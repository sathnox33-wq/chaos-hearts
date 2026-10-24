# One settings line: $(t) and the current value of $(k) ch.cfg.
$function ch:menu/text {t:"$(t): ",c:"gray"}
$execute store result storage ch:tmp sc int 1 run scoreboard players get $(k) ch.cfg
data modify storage ch:tmp dl.body append value {text:"",color:"white"}
data modify storage ch:tmp dl.body[-1].text set string storage ch:tmp sc
function ch:menu/text {t:"\\n",c:"gray"}
