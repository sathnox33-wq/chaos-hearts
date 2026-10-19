function ch:menu/new {t:"Your Hearts"}
function ch:gen/count
execute if score #owned ch.tmp matches 0 run function ch:menu/text {t:"You hold no Chaos Heart yet.",c:"gray"}
function ch:gen/menu_hearts
function ch:menu/text {t:"\\nThe newest heart you won is the one you drop if you lose a PvP fight. Your mastery stays with you even if a heart is lost.",c:"dark_gray"}
function ch:menu/button {l:"Back",c:0}
function ch:menu/show
