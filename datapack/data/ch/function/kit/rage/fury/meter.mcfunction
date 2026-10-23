# Writes Fury as a 0..100 share of the cap into the HUD meter.
scoreboard players operation #m ch.tmp = @s ch.rage.fury
scoreboard players operation #m ch.tmp *= #100 ch.g
scoreboard players set #cap ch.tmp 100
execute if score @s ch.awake matches 1 run scoreboard players set #cap ch.tmp 150
scoreboard players operation #m ch.tmp /= #cap ch.tmp
scoreboard players operation @s ch.meter = #m ch.tmp
