# Once a second: up to three enemies in range are marked, and bolts fall on the marks 10 ticks later.
tag @s add ch.caster
scoreboard players set #v1 ch.storm.g 60
scoreboard players set #v2 ch.storm.g 1
scoreboard players set #v3 ch.storm.g 0
scoreboard players set #v4 ch.storm.g 0
execute unless score @s ch.b3 matches 2.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..14,sort=random,limit=3] at @s run function ch:kit/storm/tempest/mark
execute if score @s ch.b3 matches 2.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..17,sort=random,limit=3] at @s run function ch:kit/storm/tempest/mark
tag @s remove ch.caster
