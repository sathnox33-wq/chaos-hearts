# While vanished: only you see your own faint shimmer.
scoreboard players remove @s ch.speed.van 1
execute if score #t4 ch.speed.g matches 0 run particle minecraft:dust{color:[0.16,0.83,0.95],scale:0.7} ~ ~1 ~ 0.2 0.4 0.2 0 1 normal @s
execute if score @s ch.speed.van matches ..0 run function ch:kit/speed/van/reveal
