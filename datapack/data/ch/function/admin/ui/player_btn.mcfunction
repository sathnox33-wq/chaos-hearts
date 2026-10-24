# As an online player: adds a button with their name that opens their admin page.
execute store result score #pc ch.tmp run scoreboard players get @s ch.pid
scoreboard players add #pc ch.tmp 1000
execute store result storage ch:tmp ap.c int 1 run scoreboard players get #pc ch.tmp
function ch:admin/ui/btn with storage ch:tmp ap
data modify storage ch:tmp dl.actions[-1].label set value {text:"► ?",color:"aqua"}
execute store result storage ch:tmp ap.pid int 1 run scoreboard players get @s ch.pid
function ch:admin/ui/player_name with storage ch:tmp ap
