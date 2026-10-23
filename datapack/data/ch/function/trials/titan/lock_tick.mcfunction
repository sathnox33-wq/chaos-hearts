# While Golgoth winds up an attack it stands still; when the windup ends it moves again.
scoreboard players remove @s ch.v6 1
execute if score @s ch.titan.tb2 matches 1 if score @s ch.v6 matches 0 run function ch:trials/titan/stomp_hit
execute if score @s ch.titan.tb2 matches 1 if score @s ch.v6 matches 1.. run particle minecraft:dust{color:[1.0,0.478,0.165],scale:2.0} ~ ~0.2 ~ 3 0 3 0 10
execute if score @s ch.v6 matches 0 run data merge entity @s {NoAI:0b}
execute if score @s ch.v6 matches 0 run scoreboard players set @s ch.titan.tb2 0
