# A ram block, every tick: charges 0.6 blocks; the bottom row hits and shoves; shatters at walls or the end.
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run function ch:kit/frozen/wall/ram_end
execute positioned ^ ^ ^0.6 unless block ~ ~0.5 ~ #ch:passable run return run function ch:kit/frozen/wall/ram_end
tp @s ^ ^ ^0.6
particle minecraft:snowflake ~ ~0.5 ~ 0.3 0.3 0.3 0.04 2
particle minecraft:block{block_state:"minecraft:snow_block"} ~ ~0.1 ~ 0.3 0 0.3 0.05 2
execute if score @s ch.v1 matches 1 run function ch:kit/frozen/wall/ram_hit
tag @a remove ch.caster
