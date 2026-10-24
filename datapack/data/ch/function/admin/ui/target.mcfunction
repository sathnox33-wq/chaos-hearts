# The picked player's page: their hearts and mastery, and buttons to give, take, switch, heal and reset.
function ch:menu/new {t:"Manage player"}
data modify storage ch:tmp dl.body append value {text:"",color:"aqua",bold:true}
execute store result storage ch:tmp ap.pid int 1 run scoreboard players get @s ch.adt
function ch:admin/ui/body_name with storage ch:tmp ap
function ch:menu/text {t:"\\n\\n",c:"gray"}
execute as @a[tag=ch.adtgt,limit=1] run function ch:gen/count
execute if score #owned ch.tmp matches 0 run function ch:menu/text {t:"No Chaos Hearts.\\n",c:"gray"}
execute as @a[tag=ch.adtgt,limit=1] run function ch:gen/menu_hearts
function ch:menu/text {t:"\\nGive adds a new heart (ignores the unique and max-hearts limits). Take removes one; mastery stays.",c:"dark_gray"}
function ch:gen/admin_buttons
function ch:admin/ui/btn {l:"★ Mastery and awakening",c:5}
function ch:admin/ui/btn {l:"⟲ Reset cooldowns",c:30}
function ch:admin/ui/btn {l:"✚ Heal and feed",c:31}
function ch:admin/ui/btn {l:"← Back",c:1}
function ch:menu/show
