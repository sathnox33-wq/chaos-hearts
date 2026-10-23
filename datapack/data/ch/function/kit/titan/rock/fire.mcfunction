# Fires one boulder projectile and gives it the ground block, its yaw offset and an upward lob.
function ch:api/proj {item:"minecraft:cobblestone",scale:1.3,speed:5,life:60,hit:"ch:api/noop",step:"ch:kit/titan/rock/step",end:"ch:kit/titan/rock/boom",pierce:0,ignore:"ch.powner"}
execute as @e[type=item_display,tag=ch.lnew,tag=!ch.titan.rk,distance=..4,limit=1] at @s run function ch:kit/titan/rock/style with storage ch:tmp trk
