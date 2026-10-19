function ch:menu/feat_bits with storage ch:tmp h
$scoreboard players set #bit ch.tmp $(bit)
scoreboard players operation #fb ch.tmp /= #bit ch.tmp
scoreboard players operation #fb ch.tmp %= #2 ch.g
execute if score #fb ch.tmp matches 1 run function ch:menu/text {t:"✔ ",c:"green"}
execute if score #fb ch.tmp matches 0 run function ch:menu/text {t:"○ ",c:"dark_gray"}
$function ch:menu/copy {p:"m.feats[$(n)].name",c:"white"}
function ch:menu/text {t:"  +",c:"yellow"}
$function ch:menu/copy {p:"m.feats[$(n)].xp",c:"yellow"}
function ch:menu/text {t:" XP\\n",c:"yellow"}
$function ch:menu/copy {p:"m.feats[$(n)].desc",c:"gray"}
function ch:menu/text {t:"\\n\\n",c:"gray"}
