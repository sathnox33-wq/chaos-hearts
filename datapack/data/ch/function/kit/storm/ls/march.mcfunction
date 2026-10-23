# Thunderstorm: two more bolts march forward from the first, 3.5 and 7 blocks on.
scoreboard players operation #v1 ch.storm.g = @s ch.v1
scoreboard players operation #v1 ch.storm.g *= #c7 ch.storm.g
scoreboard players operation #v1 ch.storm.g /= #c10 ch.storm.g
scoreboard players set #v2 ch.storm.g 0
scoreboard players set #v3 ch.storm.g 1
scoreboard players set #v4 ch.storm.g 0
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.gm","ch.noability"]}
scoreboard players set #gn ch.storm.g 0
execute rotated as @a[tag=ch.caster,limit=1] rotated ~ 0 positioned ^ ^3 ^3.5 run function ch:kit/storm/fn/ground
execute at @e[type=marker,tag=ch.storm.gm,limit=1] run function ch:kit/storm/ls/mark_march {t:5}
scoreboard players set #gn ch.storm.g 0
execute rotated as @a[tag=ch.caster,limit=1] rotated ~ 0 positioned ^ ^3 ^7 run function ch:kit/storm/fn/ground
execute at @e[type=marker,tag=ch.storm.gm,limit=1] run function ch:kit/storm/ls/mark_march {t:10}
kill @e[type=marker,tag=ch.storm.gm]
