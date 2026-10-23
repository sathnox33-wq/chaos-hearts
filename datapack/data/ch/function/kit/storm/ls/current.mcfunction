# One tick of a Ground Current: one block forward along the floor, sparks, a crack, and a hit on what it reaches.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
execute rotated as @s positioned ^ ^ ^1 if block ~ ~ ~ #ch:passable if block ~ ~-1 ~ #ch:passable unless block ~ ~-2 ~ #ch:passable run return run function ch:kit/storm/ls/current_move {dy:-1}
execute rotated as @s positioned ^ ^ ^1 if block ~ ~ ~ #ch:passable unless block ~ ~-1 ~ #ch:passable run return run function ch:kit/storm/ls/current_move {dy:0}
execute rotated as @s positioned ^ ^ ^1 unless block ~ ~ ~ #ch:passable if block ~ ~1 ~ #ch:passable run return run function ch:kit/storm/ls/current_move {dy:1}
kill @s
