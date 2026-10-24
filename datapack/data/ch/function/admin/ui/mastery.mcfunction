# The picked player's mastery page: for each heart they hold, set its mastery or awaken it.
function ch:menu/new {t:"Mastery and awakening"}
data modify storage ch:tmp dl.body append value {text:"",color:"aqua",bold:true}
execute store result storage ch:tmp ap.pid int 1 run scoreboard players get @s ch.adt
function ch:admin/ui/body_name with storage ch:tmp ap
function ch:menu/text {t:"\\n\\n",c:"gray"}
execute as @a[tag=ch.adtgt,limit=1] run function ch:gen/count
execute if score #owned ch.tmp matches 0 run function ch:menu/text {t:"No Chaos Hearts. Give one first.\\n",c:"gray"}
execute as @a[tag=ch.adtgt,limit=1] run function ch:gen/menu_hearts
function ch:menu/text {t:"\\nEach row: set mastery to 0 / 25 / 50 / 75 / 100, or awaken the heart (as if its trial was won).",c:"dark_gray"}
function ch:gen/admin_mastery_buttons
function ch:admin/ui/btn {l:"← Back",c:1}
function ch:admin/ui/back_target
function ch:admin/ui/show6
