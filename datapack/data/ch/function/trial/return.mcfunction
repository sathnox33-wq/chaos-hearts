# As the challenger: back to where they entered, healed, with their old game mode.
execute store result storage ch:tmp n.pid int 1 run scoreboard players get @s ch.pid
function ch:trial/return2 with storage ch:tmp n
