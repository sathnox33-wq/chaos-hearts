# Idle long enough? Pick a pattern (Tick Tock joins in phase 3). Waits shorten each phase.
scoreboard players set #wait ch.speed.g 70
execute if score @s ch.v4 matches 2 run scoreboard players set #wait ch.speed.g 55
execute if score @s ch.v4 matches 3.. run scoreboard players set #wait ch.speed.g 38
execute if score @s ch.v3 < #wait ch.speed.g run return 0
execute unless entity @a[tag=ch.challenger,distance=..70,limit=1] run return 0
scoreboard players set @s ch.v3 0
scoreboard players set @s ch.v2 0
execute store result score #r ch.speed.g run random value 1..2
execute if score @s ch.v4 matches 3.. store result score #r ch.speed.g run random value 1..3
scoreboard players operation @s ch.v1 = #r ch.speed.g
