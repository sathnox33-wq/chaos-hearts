# One piece of a setting moon fades out (the marker anchor just goes).
execute if entity @s[type=marker] run return run kill @s
scoreboard players set @s ch.life 4
