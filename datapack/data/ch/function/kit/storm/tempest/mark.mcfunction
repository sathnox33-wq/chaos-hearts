# As a target of the Tempest: a mark at its feet, then a bolt there 10 ticks later.
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.gm","ch.noability"]}
scoreboard players set #gn ch.storm.g 0
function ch:kit/storm/fn/ground
execute as @e[type=marker,tag=ch.storm.gm,limit=1] at @s run function ch:kit/storm/tempest/mark_at
kill @e[type=marker,tag=ch.storm.gm]
