# A boulder in flight: gravity bends it down, it tumbles, and it trails dust and grit.
tp @s ~ ~ ~ ~ ~2.2
scoreboard players operation #ti_m ch.tmp = #now ch.g
scoreboard players operation #ti_m ch.tmp %= #4 ch.g
execute if score #ti_m ch.tmp matches 0 run data merge entity @s {start_interpolation:0,interpolation_duration:2,transformation:{left_rotation:[0.38f,0f,0f,0.92f]}}
execute if score #ti_m ch.tmp matches 1 run data merge entity @s {start_interpolation:0,interpolation_duration:2,transformation:{left_rotation:[0.71f,0f,0f,0.71f]}}
execute if score #ti_m ch.tmp matches 2 run data merge entity @s {start_interpolation:0,interpolation_duration:2,transformation:{left_rotation:[0.92f,0f,0f,0.38f]}}
execute if score #ti_m ch.tmp matches 3 run data merge entity @s {start_interpolation:0,interpolation_duration:2,transformation:{left_rotation:[1f,0f,0f,0f]}}
particle minecraft:campfire_cosy_smoke ~ ~ ~ 0.15 0.15 0.15 0.005 1
particle minecraft:dust{color:[0.478,0.455,0.416],scale:1.8} ~ ~ ~ 0.3 0.3 0.3 0 3
particle minecraft:falling_dust{block_state:"minecraft:gravel"} ~ ~ ~ 0.3 0.3 0.3 0 2
