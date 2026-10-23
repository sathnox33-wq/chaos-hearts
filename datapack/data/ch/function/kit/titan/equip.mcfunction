# Titan becomes active: Mountain's Endurance is applied at once and the stone wakes with a rumble.
scoreboard players set @s ch.titan.hp -1
scoreboard players operation #ti_pid ch.tmp = @s ch.pid
function ch:kit/titan/passive/second
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.4 0.6 0.4 0.1 30
particle minecraft:dust{color:[0.788,0.643,0.361],scale:1.4} ~ ~1 ~ 0.5 0.7 0.5 0 20
playsound chaoshearts:titan_stoneskin player @s ~ ~ ~ 0.5 1.4
