# The bolt lands (it snaps onto its target if they are within 3 blocks of the mark).
execute unless entity @a[tag=ch.caster,limit=1] run return 0
scoreboard players operation #e ch.storm.g = @s ch.v2
execute if score #e ch.storm.g matches 1.. as @e[distance=..3.5,type=!#ch:ignore] if score @s ch.eid = #e ch.storm.g run tag @s add ch.storm.trk
execute if entity @e[tag=ch.storm.trk,limit=1] run tp @s @e[tag=ch.storm.trk,limit=1]
tag @e[tag=ch.storm.trk] remove ch.storm.trk
execute at @s run function ch:kit/storm/ls/impact
