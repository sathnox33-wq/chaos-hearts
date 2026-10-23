# Snowfield ambience: snow and ash on the wind around the challenger, the howl of the wind.
scoreboard players operation #fb ch.tmp = #now ch.g
scoreboard players operation #fb ch.tmp %= #4 ch.g
execute if score #fb ch.tmp matches 0 at @a[tag=ch.challenger,distance=..90] run particle minecraft:snowflake ~ ~4 ~ 9 3 9 0.02 30
execute if score #fb ch.tmp matches 2 at @a[tag=ch.challenger,distance=..90] run particle minecraft:white_ash ~ ~3 ~ 8 3 8 0 10
execute if score #t20 ch.g matches 0 run particle minecraft:end_rod ~ ~-0.5 ~ 2 0 2 0.01 4
scoreboard players operation #fb ch.tmp = #now ch.g
scoreboard players set #f_k ch.tmp 100
scoreboard players operation #fb ch.tmp %= #f_k ch.tmp
execute if score #fb ch.tmp matches 0 run playsound minecraft:item.elytra.flying ambient @a[distance=..90] ~ ~ ~ 0.4 0.5
execute if score #fb ch.tmp matches 50 run playsound minecraft:block.powder_snow.step ambient @a[distance=..90] ~ ~ ~ 1 0.5
