data modify storage ch:tmp dl.body append value {text:"",bold:true}
data modify storage ch:tmp dl.body[-1].text set from storage ch:tmp m.title
data modify storage ch:tmp dl.body[-1].color set from storage ch:tmp m.color
function ch:menu/text {t:" Heart  (active)\\n",c:"white"}
function ch:menu/copy {p:"m.lore",c:"dark_gray"}
function ch:menu/text {t:"\\n\\nMastery ",c:"gray"}
function ch:menu/score {o:"ch.lvl",c:"white"}
function ch:menu/text {t:" / 100",c:"gray"}
execute if score @s ch.awake matches 1 run function ch:menu/text {t:"   ✦ Awakened",c:"gold"}
execute unless score @s ch.awake matches 1 if score @s ch.lvl matches 100.. run function ch:menu/text {t:"   Ready for its trial at an Awakening Altar",c:"yellow"}
function ch:menu/text {t:"\\n",c:"gray"}
