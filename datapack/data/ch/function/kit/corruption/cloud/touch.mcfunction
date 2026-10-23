# As an enemy inside a plague cloud.
execute unless score @s ch.corruption.cid = #ccid ch.tmp run scoreboard players add @e[type=marker,tag=ch.corruption.ccur,limit=1] ch.v3 1
scoreboard players operation @s ch.corruption.cid = #ccid ch.tmp
execute if score @e[type=marker,tag=ch.corruption.ccur,limit=1] ch.v4 matches 0 run function ch:kit/corruption/poison {sec:2,amp:0}
execute if score @e[type=marker,tag=ch.corruption.ccur,limit=1] ch.v4 matches 1.. run function ch:kit/corruption/poison {sec:2,amp:1}
execute if score @e[type=marker,tag=ch.corruption.ccur,limit=1] ch.v5 matches 1 run function ch:kit/corruption/afflict {e:"wither",sec:2,amp:1}
scoreboard players add @a[tag=ch.caster,limit=1] ch.corruption.m 1
scoreboard players set @a[tag=ch.caster,limit=1] ch.corruption.mt 100
