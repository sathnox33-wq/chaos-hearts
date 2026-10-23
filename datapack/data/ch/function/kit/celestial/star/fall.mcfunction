# A star falls: 1.37 blocks a tick along its line, with a trail of light (and fire for a comet); then it strikes.
scoreboard players remove @s ch.life 1
tp @s ^ ^ ^1.374
execute at @s run particle minecraft:end_rod ~ ~ ~ 0.12 0.12 0.12 0.02 3
execute at @s run particle minecraft:dust{color:[1.0,0.827,0.42],scale:1.6} ~ ~ ~ 0.15 0.15 0.15 0 2
execute at @s run particle minecraft:firework ~ ~ ~ 0.1 0.1 0.1 0.02 1
execute if score @s ch.v4 matches 1 at @s run particle minecraft:flame ~ ~ ~ 0.25 0.25 0.25 0.03 6
execute if score @s ch.v4 matches 1 at @s run particle minecraft:lava ~ ~ ~ 0.2 0.2 0.2 0 1
execute if score @s ch.life matches 6 at @s run playsound minecraft:entity.firework_rocket.launch player @a ~ ~ ~ 1 0.7
execute if score @s ch.life matches ..0 at @s run function ch:kit/celestial/star/impact
