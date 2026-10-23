# One tick of a fissure: after the windup it advances 1.1 blocks a tick, hugging the ground.
execute if score @s ch.v1 matches 1.. run return run scoreboard players remove @s ch.v1 1
scoreboard players add @s ch.v2 1
execute if score @s ch.v2 matches 1 run function ch:kit/rage/fissure/impact
tp @s ^ ^ ^1.1
execute at @s unless block ~ ~ ~ #ch:passable run tp @s ~ ~1 ~
execute at @s unless block ~ ~ ~ #ch:passable run return run function ch:kit/rage/fissure/end
execute at @s if block ~ ~-1 ~ #ch:passable run tp @s ~ ~-1 ~
execute at @s run function ch:kit/rage/fissure/burst
execute if score @s ch.v2 matches 10.. at @s run function ch:kit/rage/fissure/end
