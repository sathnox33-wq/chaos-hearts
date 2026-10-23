# Rewind anchors expire on their own if the fracture never ended.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run kill @s
