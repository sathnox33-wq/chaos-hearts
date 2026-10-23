# A decoy, every tick: shimmers, runs (Mirror Feint) and fades at the end of its life.
scoreboard players remove @s ch.life 1
execute if score #t2 ch.speed.g matches 0 run particle minecraft:dust_color_transition{from_color:[0.96,0.88,0.26],to_color:[0.16,0.83,0.95],scale:1.3} ~ ~1 ~ 0.3 0.6 0.3 0 2
execute if score @s ch.v1 matches 1.. run function ch:kit/speed/van/drun
execute if score @s ch.life matches ..0 run function ch:kit/speed/van/dend
