# The skill tree of the active heart: three branches of five nodes, points from awakening and ascension.
execute unless function ch:menu/load run return run function ch:menu/main
function ch:menu/new {t:"Skill Tree"}
execute unless score @s ch.awake matches 1 run function ch:menu/text {t:"This heart is not awakened yet. Reach mastery 100 and win its Awakening Trial at an altar to open the tree.\\n\\n",c:"yellow"}
function ch:menu/points with storage ch:tmp h
function ch:menu/text {t:"Points available: ",c:"gray"}
execute store result storage ch:tmp sc int 1 run scoreboard players get #avail ch.tmp
data modify storage ch:tmp dl.body append value {text:"",color:"gold",bold:true}
data modify storage ch:tmp dl.body[-1].text set string storage ch:tmp sc
function ch:menu/text {t:"   Nodes cost 1, 2, 2, 3 and 4 (capstone). Only one capstone per heart.\\n\\n",c:"dark_gray"}
function ch:menu/branch {b:0,s:"ch.b1",c:31}
function ch:menu/branch {b:1,s:"ch.b2",c:32}
function ch:menu/branch {b:2,s:"ch.b3",c:33}
function ch:menu/text {t:"Respec: the first one is free, then it costs XP levels.",c:"dark_gray"}
function ch:menu/button {l:"Respec",c:39}
function ch:menu/button {l:"Back",c:0}
function ch:menu/show
