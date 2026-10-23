# Chrono Collapse, last second: rings tighten, the ticking races. Get out.
execute if score @s ch.life matches 20 run function ch:kit/speed/frac/warn_start with storage ch:kspeed f
scoreboard players operation #k ch.speed.g = @s ch.life
scoreboard players operation #k ch.speed.g %= #c4 ch.speed.g
execute if score #k ch.speed.g matches 0 if score @s ch.life matches 13..20 run playsound minecraft:block.note_block.hat player @a ~ ~ ~ 1.2 1.6
execute if score #k ch.speed.g matches 0 if score @s ch.life matches 5..12 run playsound minecraft:block.note_block.hat player @a ~ ~ ~ 1.4 1.9
execute if score @s ch.life matches ..4 run playsound minecraft:block.note_block.hat player @a ~ ~ ~ 1.5 2
