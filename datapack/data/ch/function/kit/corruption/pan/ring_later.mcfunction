# Queues one rotling rise here, a few ticks apart; the spot cracks open first.
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:2046478,s0:0.3,s1:2.2,t:6,life:30,spin:0,dy:0.0}
particle minecraft:block{block_state:"minecraft:rooted_dirt"} ~ ~0.2 ~ 0.4 0.1 0.4 0 10
scoreboard players operation #cdl ch.tmp = #ci ch.tmp
scoreboard players operation #cdl ch.tmp *= #4 ch.g
scoreboard players add #cdl ch.tmp 4
execute store result storage ch:corruption l.t int 1 run scoreboard players get #cdl ch.tmp
function ch:kit/corruption/pan/later with storage ch:corruption l
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v1 = #cll ch.tmp
