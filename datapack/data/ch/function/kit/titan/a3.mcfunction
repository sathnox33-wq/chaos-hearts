# Boulder Toss. Level: tear up a boulder and hurl it in an arc. Up: Meteor Lob, it falls on a marked spot near
# the closest enemy. Down: Shrapnel, smash it into a fan of stone shards.
scoreboard players operation #ti_pid ch.tmp = @s ch.pid
execute if score #var ch.tmp matches 2 run return run function ch:kit/titan/rock/shrapnel
scoreboard players set #ti_big ch.tmp 0
function ch:kit/titan/fx/ground
function ch:kit/titan/rock/lift with storage ch:tmp tg
scoreboard players operation #ti_x ch.tmp = #var ch.tmp
function ch:kit/titan/fx/later {t:8,then:"ch:kit/titan/rock/throw"}
data modify entity @e[type=marker,tag=ch.titan.lset,distance=..0.01,limit=1,sort=nearest] data.b set from storage ch:tmp tg.b
return 1
