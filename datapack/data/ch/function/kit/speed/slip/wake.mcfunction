# One wake marker: glows, then slows (or burns) whoever crosses it.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
execute if score #t2 ch.speed.g matches 0 run particle minecraft:dust_color_transition{from_color:[0.96,0.88,0.26],to_color:[0.16,0.83,0.95],scale:1.3} ~ ~0.15 ~ 0.25 0.05 0.25 0 2
execute if score #t2 ch.speed.g matches 0 if score @s ch.v2 matches 1 run particle minecraft:dust{color:[0.96,0.88,0.26],scale:0.7} ~ ~0.1 ~ 0.6 0.02 0.6 0 2
execute if score #t2 ch.speed.g matches 0 if score @s ch.v1 matches 1 run particle minecraft:small_flame ~ ~0.2 ~ 0.2 0.1 0.2 0.01 2
execute if score #t4 ch.speed.g matches 0 if score @s ch.v1 matches 1 run particle minecraft:electric_spark ~ ~0.3 ~ 0.3 0.1 0.3 0.05 2
execute if score #t5 ch.speed.g matches 0 run function ch:kit/speed/slip/wake_hit
