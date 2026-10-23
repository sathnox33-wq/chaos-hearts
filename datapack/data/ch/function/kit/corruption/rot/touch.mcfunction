# As an enemy near a rot field: only those standing on it (within 2 blocks of its height) are affected.
execute store result score #cey ch.tmp run data get entity @s Pos[1] 10
scoreboard players operation #cey ch.tmp -= #cry ch.tmp
execute unless score #cey ch.tmp matches -10..20 run return 0
execute if score #cwa ch.tmp matches 1 run function ch:kit/corruption/afflict {e:"wither",sec:2,amp:1}
execute unless score #cwa ch.tmp matches 1 run function ch:kit/corruption/afflict {e:"wither",sec:2,amp:0}
execute if score #cmi ch.tmp matches 1 run function ch:kit/corruption/afflict {e:"slowness",sec:2,amp:2}
execute unless score #cmi ch.tmp matches 1 run function ch:kit/corruption/afflict {e:"slowness",sec:2,amp:0}
execute if score #ct ch.tmp matches 0 run scoreboard players set #cd ch.tmp 10
execute if score #ct ch.tmp matches 0 run function ch:kit/corruption/hurt
tag @s add ch.corruption.inrot
scoreboard players operation @s ch.corruption.ro = #cro ch.tmp
scoreboard players set @s ch.corruption.rt 12
particle minecraft:dust{color:[0.482,0.82,0.227],scale:0.9} ~ ~0.3 ~ 0.3 0.1 0.3 0 3
