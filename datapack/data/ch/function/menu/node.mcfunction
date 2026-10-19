$execute if score #n ch.tmp matches $(k) run function ch:menu/text {t:" ➜ ",c:"yellow"}
$execute if score #n ch.tmp matches ..$(k) unless score #n ch.tmp matches $(k) run function ch:menu/text {t:" ○ ",c:"dark_gray"}
$execute unless score #n ch.tmp matches ..$(k) run function ch:menu/text {t:" ✔ ",c:"green"}
$function ch:menu/copy {p:"m.br[$(b)].n[$(k)].name",c:"white"}
function ch:menu/text {t:": ",c:"dark_gray"}
$function ch:menu/copy {p:"m.br[$(b)].n[$(k)].desc",c:"gray"}
function ch:menu/text {t:"\\n",c:"gray"}
