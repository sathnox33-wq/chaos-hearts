# Colossus. Level: grow to giant size, every blow a shockwave. Up: Titanfall, leap and land as a giant on a
# marked crater. Down: Bastion, a rooted giant fortress that pulses quakes around it.
scoreboard players operation #ti_pid ch.tmp = @s ch.pid
execute if score @s ch.titan.col matches 1.. run return fail
execute if score @s ch.titan.air matches 1.. run return fail
execute if score #var ch.tmp matches 1 run return run function ch:kit/titan/col/titanfall
scoreboard players set @s ch.titan.colm 0
execute if score #var ch.tmp matches 2 run scoreboard players set @s ch.titan.colm 2
function ch:kit/titan/col/begin
return 1
