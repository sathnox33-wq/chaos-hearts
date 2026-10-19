# Rotation is the push direction and the position is the player's: a wind charge flies into their back and bursts.
function ch:api/vec {s:0.9}
scoreboard players set #vy ch.tmp 100
execute positioned ^ ^0.4 ^-0.9 summon minecraft:wind_charge run function ch:api/motion
return 1
