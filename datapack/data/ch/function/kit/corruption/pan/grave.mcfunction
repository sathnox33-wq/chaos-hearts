# Down: the ground splits around you for a second (telegraph), then the dead erupt beneath your enemies.
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:2046478,s0:1.0,s1:24.0,t:20,life:40,spin:0,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13161514,s0:24.0,s1:2.0,t:20,life:22,spin:170,dy:0.0}
particle minecraft:block{block_state:"minecraft:rooted_dirt"} ~ ~0.2 ~ 6 0.1 6 0 80
playsound minecraft:entity.warden.dig player @a ~ ~ ~ 2 0.6
playsound minecraft:entity.warden.emerge player @a ~ ~ ~ 1 0.6
function ch:api/fx/shake {s:1,t:20,r:14}
function ch:api/later {t:20,then:"ch:kit/corruption/pan/grave_erupt"}
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v1 = #cll ch.tmp
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v2 = #cln ch.tmp
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v3 = #cnec ch.tmp
