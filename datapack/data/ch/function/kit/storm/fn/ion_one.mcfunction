# One ionized entity, one tick.
scoreboard players remove @s ch.storm.ion 1
scoreboard players set #ion ch.storm.g 1
execute if score #t5 ch.storm.g matches 0 run particle minecraft:dust{color:[0.61,0.48,1.0],scale:0.9} ~ ~1.1 ~ 0.3 0.5 0.3 0 2
