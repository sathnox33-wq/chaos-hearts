# An ally is shielded in stone.
effect give @s minecraft:resistance 6 0 true
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.4 0.6 0.4 0.05 25
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:13214812,s0:2.4,s1:1.6,t:4,life:9,spin:60,dy:0.0}
playsound minecraft:block.stone.place player @s ~ ~ ~ 1 0.7
