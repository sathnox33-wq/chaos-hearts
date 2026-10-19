# Moves the HUD pen #dx ch.tmp pixels (-200..200).
scoreboard players operation #adv ch.tmp += #dx ch.tmp
scoreboard players add #dx ch.tmp 200
execute store result storage ch:tmp n.i int 1 run scoreboard players get #dx ch.tmp
function ch:core/hud/move2 with storage ch:tmp n
