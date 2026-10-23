# One fast stone shard.
function ch:api/proj {item:"minecraft:cobblestone",scale:0.38,speed:7,life:16,hit:"ch:kit/titan/rock/shard_hit",step:"ch:kit/titan/rock/shard_step",end:"ch:kit/titan/rock/shard_end",pierce:0,ignore:"ch.powner"}
execute as @e[type=item_display,tag=ch.lnew,tag=!ch.titan.rk,distance=..4,limit=1] at @s run function ch:kit/titan/rock/shard_style with storage ch:tmp trk
