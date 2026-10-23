# One tick of Momentum charging; a soft rising tick at each second, a flare when full.
scoreboard players add @s ch.speed.spr 1
execute if score @s ch.speed.spr matches 20 run playsound minecraft:block.note_block.hat player @s ~ ~ ~ 0.5 1.2
execute if score @s ch.speed.spr matches 40 run playsound minecraft:block.note_block.hat player @s ~ ~ ~ 0.6 1.6
execute if score @s ch.speed.spr matches 60 run function ch:kit/speed/p/charged
