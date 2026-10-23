# As the new storm marker.
tag @s remove ch.corruption.snew
function ch:api/own
scoreboard players set @s ch.life 160
scoreboard players set @s ch.t 0
scoreboard players operation @s ch.v6 = #cnec ch.tmp
