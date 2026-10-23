# Dazed after a crash.
scoreboard players remove @s ch.v3 1
particle minecraft:dust{color:[1.0,0.9,0.3],scale:1.0} ~ ~3.2 ~ 0.5 0.1 0.5 0 2
execute if score @s ch.v3 matches ..0 run function ch:trials/rage/charge_end
