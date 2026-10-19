# Moves the pen to $(x) pixels from the screen centre.
$scoreboard players set #dx ch.tmp $(x)
scoreboard players operation #dx ch.tmp -= #adv ch.tmp
function ch:core/hud/move
