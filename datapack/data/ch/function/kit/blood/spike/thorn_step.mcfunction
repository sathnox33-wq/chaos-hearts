# One tick of Blood Thorns: after the seep, a thorn bursts up every 1 block, hugging the ground.
execute if score @s ch.v1 matches 1.. run return run scoreboard players remove @s ch.v1 1
scoreboard players add @s ch.v2 1
tp @s ^ ^ ^1
execute at @s unless block ~ ~ ~ #ch:passable run tp @s ~ ~1 ~
execute at @s unless block ~ ~ ~ #ch:passable run return run kill @s
execute at @s if block ~ ~-1 ~ #ch:passable run tp @s ~ ~-1 ~
execute at @s run function ch:kit/blood/spike/thorn
execute if score @s ch.v2 matches 10.. run kill @s
