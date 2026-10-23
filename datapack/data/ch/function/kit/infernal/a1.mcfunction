# Fireball Volley. Level: a fan of 3 (5) fireballs. Up: lobbed mortar shells that splash fire where they land. Down: a pinwheel of embers around you.
scoreboard players operation #i_var ch.tmp = #var ch.tmp
function ch:kit/infernal/overheat
function ch:kit/infernal/pal
scoreboard players add #next ch.infernal.vid 1
scoreboard players operation @s ch.infernal.vid = #next ch.infernal.vid
scoreboard players set @s ch.infernal.sk 0
execute if score @s ch.b1 matches 3.. unless score #i_var ch.tmp matches 2 run function ch:kit/infernal/volley/lock
function ch:kit/infernal/volley/cast_fx with storage ch:tmp ki
execute if score #i_var ch.tmp matches 1 run return run function ch:kit/infernal/volley/mortar
execute if score #i_var ch.tmp matches 2 run return run function ch:kit/infernal/volley/pinwheel
return run function ch:kit/infernal/volley/fan
