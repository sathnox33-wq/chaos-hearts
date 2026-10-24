# Panel: every dropped heart goes back to the player who lost it now, instead of waiting for its window to end.
execute unless data storage ch:reg hearts[{state:"dropped"}] run return run tellraw @s {text:"No hearts are lying on the ground.",color:"gray"}
data modify storage ch:reg hearts[{state:"dropped"}].exp set value 0
function ch:heart/sweep
tellraw @s {text:"Dropped hearts returned to their owners.",color:"gray"}
