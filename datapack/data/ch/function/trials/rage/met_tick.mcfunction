# A meteor coming down.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches 10 run playsound minecraft:entity.blaze.shoot master @a[distance=..90] ~ ~ ~ 1.4 0.5
execute if score @s ch.life matches ..0 run function ch:trials/rage/met_hit
