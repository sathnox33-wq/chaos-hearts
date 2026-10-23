# Vael, every tick: decorations follow, and the time thief picks its next pattern when idle.
function ch:trials/speed/b/deco
execute if score #t2 ch.speed.g matches 0 run particle minecraft:dust_color_transition{from_color:[0.96,0.88,0.26],to_color:[0.16,0.83,0.95],scale:1.3} ~ ~1 ~ 0.3 0.6 0.3 0 2
execute if score @s ch.v1 matches 1.. run scoreboard players add @s ch.v2 1
execute if score @s ch.v1 matches 0 run scoreboard players add @s ch.v3 1
execute if score @s ch.v1 matches 0 run function ch:trials/speed/b/choose
execute if score @s ch.v1 matches 1 run function ch:trials/speed/b/blink
execute if score @s ch.v1 matches 2 run function ch:trials/speed/b/images
execute if score @s ch.v1 matches 3 run function ch:trials/speed/b/tock
execute if score @s ch.v4 matches 2.. run scoreboard players add @s ch.v5 1
execute if score @s ch.v5 matches 240.. run function ch:trials/speed/b/theft
