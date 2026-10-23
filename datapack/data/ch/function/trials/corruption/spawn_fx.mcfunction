# A mob crawls up out of the rot.
particle minecraft:block{block_state:"minecraft:rooted_dirt"} ~ ~0.3 ~ 0.4 0.2 0.4 0 30
particle minecraft:dust{color:[0.482,0.82,0.227],scale:1.6} ~ ~0.8 ~ 0.4 0.6 0.4 0 20
particle minecraft:sculk_soul ~ ~0.5 ~ 0.3 0.3 0.3 0.03 5
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:2046478,s0:0.3,s1:2.4,t:6,life:20,spin:0,dy:0.0}
playsound minecraft:block.rooted_dirt.break hostile @a ~ ~ ~ 1 0.6
