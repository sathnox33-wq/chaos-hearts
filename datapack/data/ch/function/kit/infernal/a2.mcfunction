# Flame Wall. Level: a wall across your path (a ring around you with Ring of Fire). Up: a tide of fire that marches forward, shoving enemies. Down: a burning lane ahead of you.
scoreboard players operation #i_var ch.tmp = #var ch.tmp
function ch:kit/infernal/overheat
function ch:kit/infernal/pal
scoreboard players set #i_dur ch.tmp 120
execute if score @s ch.b2 matches 2.. run scoreboard players set #i_dur ch.tmp 168
execute store result storage ch:tmp ki.dur int 1 run scoreboard players get #i_dur ch.tmp
scoreboard players set #i_aw ch.tmp 0
execute if score @s ch.awake matches 1 run scoreboard players set #i_aw ch.tmp 1
scoreboard players set #i_cs ch.tmp 0
execute if score @s ch.b2 matches 3.. run scoreboard players set #i_cs ch.tmp 1
scoreboard players set #i_mt ch.tmp 0
execute if score #i_var ch.tmp matches 1 run scoreboard players set #i_mt ch.tmp 30
function ch:kit/infernal/wall/cast_fx with storage ch:tmp ki
execute if score #i_var ch.tmp matches 2 run return run function ch:kit/infernal/wall/lane
execute if score @s ch.b2 matches 5.. run return run function ch:kit/infernal/wall/ring
return run function ch:kit/infernal/wall/line
