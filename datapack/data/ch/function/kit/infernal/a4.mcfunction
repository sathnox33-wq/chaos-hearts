# Inferno Avatar. Level: become a living blaze for 10 s (burning aura, seeking fireballs). Up: Ascendant, rise and hover while fire rains twice as fast. Down: Supernova, a 1.5 s charge that detonates in a huge blast.
scoreboard players operation #i_var ch.tmp = #var ch.tmp
function ch:kit/infernal/overheat
function ch:kit/infernal/pal
execute if score #i_var ch.tmp matches 2 run return run function ch:kit/infernal/avatar/nova_start with storage ch:tmp ki
scoreboard players set @s ch.infernal.avm 0
execute if score #i_var ch.tmp matches 1 run scoreboard players set @s ch.infernal.avm 1
function ch:kit/infernal/avatar/start with storage ch:tmp ki
return 1
