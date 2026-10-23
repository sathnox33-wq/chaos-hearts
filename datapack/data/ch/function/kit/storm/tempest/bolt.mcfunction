# A Tempest bolt lands on its mark; hits count toward Eye of the Storm.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
function ch:kit/storm/fn/bolt
scoreboard players operation #d ch.storm.g = @s ch.v1
scoreboard players set #hits ch.tmp 0
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.4] at @s run function ch:kit/storm/fn/zap
execute if score @s ch.v2 matches 1 run scoreboard players operation @a[tag=ch.caster,limit=1] ch.storm.th += #hits ch.tmp
execute if score @s ch.v2 matches 1 as @a[tag=ch.caster,scores={ch.storm.th=15..},limit=1] run function ch:api/feat {h:"storm",n:3}
