# One jump of the chain from here to the entity tagged ch.storm.nx; the next jump is scheduled 2 ticks later.
function ch:kit/storm/fn/arc
scoreboard players operation #d ch.storm.g = #v4 ch.storm.g
scoreboard players operation #cc ch.storm.g = #v2 ch.storm.g
execute as @e[tag=ch.storm.nx,limit=1] at @s run function ch:kit/storm/chain/zap
scoreboard players add #v3 ch.storm.g 1
scoreboard players remove #v1 ch.storm.g 1
execute if score #v3 ch.storm.g matches 5.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"storm",n:1}
scoreboard players operation #v4 ch.storm.g *= #c9 ch.storm.g
scoreboard players operation #v4 ch.storm.g /= #c10 ch.storm.g
execute if score #v1 ch.storm.g matches 1.. at @e[tag=ch.storm.nx,limit=1] positioned ~ ~1 ~ run function ch:kit/storm/chain/queue
tag @e[tag=ch.storm.nx] remove ch.storm.nx
