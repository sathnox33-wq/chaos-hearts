# Idle long enough? Call Lightning or the Chain bolt. Waits shorten each phase.
scoreboard players set #wait ch.storm.g 80
execute if score @s ch.v4 matches 2 run scoreboard players set #wait ch.storm.g 65
execute if score @s ch.v4 matches 3.. run scoreboard players set #wait ch.storm.g 50
execute if score @s ch.v3 < #wait ch.storm.g run return 0
execute unless entity @a[tag=ch.challenger,distance=..70,limit=1] run return 0
scoreboard players set @s ch.v3 0
scoreboard players set @s ch.v2 0
execute store result score @s ch.v1 run random value 1..2
