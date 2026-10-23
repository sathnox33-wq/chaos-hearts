# One block of a fault line: follows the ground over bumps, erupts, and throws what stands on it.
scoreboard players remove @s ch.life 1
scoreboard players add @s ch.v4 1
tp @s ^ ^ ^1
execute at @s if block ~ ~ ~ #ch:passable if block ~ ~-1 ~ #ch:passable run tp @s ~ ~-1 ~
execute at @s if block ~ ~ ~ #ch:passable if block ~ ~-1 ~ #ch:passable run tp @s ~ ~-1 ~
execute at @s unless block ~ ~ ~ #ch:passable run tp @s ~ ~1 ~
execute at @s unless block ~ ~ ~ #ch:passable run tp @s ~ ~1 ~
execute at @s unless block ~ ~ ~ #ch:passable run return run kill @s
execute at @s if block ~ ~-1 ~ #ch:passable run return run function ch:kit/titan/slam/stop
tag @a remove ch.caster
function ch:api/tag_owner
execute at @s run function ch:kit/titan/slam/erupt
execute if score @s ch.life matches ..0 at @s run function ch:kit/titan/slam/stop
tag @a remove ch.caster
