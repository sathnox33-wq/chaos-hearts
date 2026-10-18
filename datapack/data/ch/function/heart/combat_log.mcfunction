# This player logged out during a fight while their opponent stayed: the heart drops for the opponent.
scoreboard players operation #credit ch.tmp = @s ch.opp
execute as @a if score @s ch.pid = #credit ch.tmp run tellraw @s {text:"Your opponent came back after fleeing. Their heart dropped where they logged out.",color:"gold"}
tellraw @s {text:"You logged out during a fight, so you dropped your latest heart.",color:"red"}
function ch:heart/drop_latest
