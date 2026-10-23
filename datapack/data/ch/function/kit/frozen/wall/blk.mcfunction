# A temporary ice block, every tick.
execute if score @s ch.v1 matches 1.. run return run function ch:kit/frozen/wall/wait
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run function ch:kit/frozen/wall/melt
execute if score @s ch.life matches 20 run particle minecraft:falling_water ~ ~0.5 ~ 0.4 0.3 0.4 0 3
