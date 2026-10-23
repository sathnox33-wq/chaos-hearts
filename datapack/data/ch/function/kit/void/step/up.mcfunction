# Up: rise up to 9 blocks (12 with Far Reach).
scoreboard players set #vrs ch.tmp 18
execute if score @s ch.b1 matches 1.. run scoreboard players set #vrs ch.tmp 24
function ch:kit/void/step/walkup
