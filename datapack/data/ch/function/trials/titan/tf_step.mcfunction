# A fault walker step: marks the line, or erupts it and launches the challenger standing on it.
execute if score @s ch.v2 matches 1.. run return run scoreboard players remove @s ch.v2 1
scoreboard players remove @s ch.life 1
tp @s ^ ^ ^1.8
execute at @s unless block ~ ~ ~ #ch:passable run return run kill @s
execute if score @s ch.v1 matches 0 at @s run function ch:trials/titan/tf_mark
execute if score @s ch.v1 matches 1 at @s run function ch:trials/titan/tf_erupt
execute if score @s ch.life matches ..0 run kill @s
