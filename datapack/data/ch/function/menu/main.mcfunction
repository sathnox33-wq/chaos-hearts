function ch:menu/new {t:"Chaos Hearts"}
execute unless function ch:menu/load run function ch:menu/text {t:"You hold no Chaos Heart yet.\\nDefeat a player who carries one and collect the heart they drop.\\n",c:"gray"}
execute if score @s ch.active matches 1.. run function ch:menu/main_heart
function ch:gen/count
function ch:menu/text {t:"\\nHearts held: ",c:"gray"}
execute store result storage ch:tmp sc int 1 run scoreboard players get #owned ch.tmp
data modify storage ch:tmp dl.body append value {text:"",color:"white"}
data modify storage ch:tmp dl.body[-1].text set string storage ch:tmp sc
function ch:menu/text {t:"   (each one is an extra heart of health)\\n\\nSneak + Back shuffles your active heart.",c:"dark_gray"}
function ch:menu/button {l:"Abilities",c:1}
function ch:menu/button {l:"Skill tree",c:30}
function ch:menu/button {l:"Feats",c:3}
function ch:menu/button {l:"Your hearts",c:4}
function ch:menu/button {l:"Controls",c:5}
function ch:menu/show
