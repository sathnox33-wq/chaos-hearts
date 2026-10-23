# One half-block of the lance.
scoreboard players remove #f_ls ch.tmp 1
execute unless block ~ ~ ~ #ch:passable run return run function ch:kit/frozen/shard/lance_end
particle minecraft:end_rod ~ ~ ~ 0.03 0.03 0.03 0 1
particle minecraft:snowflake ~ ~ ~ 0.15 0.15 0.15 0.02 1
execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[dx=0,dy=0,dz=0,type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.frozen.lh] at @s run function ch:kit/frozen/shard/lance_hit
execute if score #f_ls ch.tmp matches ..0 run return run function ch:kit/frozen/shard/lance_end
execute positioned ^ ^ ^0.5 run function ch:kit/frozen/shard/lance_step
