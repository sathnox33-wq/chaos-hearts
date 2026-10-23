# Storm melee hit: Static, every 4th hit (3rd with Overload) arcs a spark to another enemy.
execute unless score @s ch.lvl matches 25.. run return 0
scoreboard players add @s ch.storm.st 1
scoreboard players set #every ch.storm.g 4
execute if score @s ch.b1 matches 4.. run scoreboard players set #every ch.storm.g 3
execute if score @s ch.storm.st < #every ch.storm.g run return 0
scoreboard players set @s ch.storm.st 0
execute as @e[tag=ch.victim,limit=1] at @s run function ch:kit/storm/p/static
