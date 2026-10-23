# A Warlord's Banner, every tick: embers; every 10 ticks a pulse of regeneration and weakness.
scoreboard players remove @s ch.life 1
particle minecraft:flame ~ ~3.8 ~ 0.15 0.2 0.15 0.01 1
scoreboard players operation #m ch.tmp = @s ch.life
scoreboard players operation #m ch.tmp %= #10 ch.g
execute if score #m ch.tmp matches 0 run function ch:kit/rage/banner/pulse
execute if score @s ch.life matches ..0 run kill @s
