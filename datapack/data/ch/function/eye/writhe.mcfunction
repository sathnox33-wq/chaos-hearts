scoreboard players add @s ch.v1 1
execute if score @s ch.v1 matches 3.. run scoreboard players set @s ch.v1 0
execute if score @s ch.v1 matches 0 run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{left_rotation:{axis:[1f,0f,0.3f],angle:2.5f}}}
execute if score @s ch.v1 matches 1 run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{left_rotation:{axis:[1f,0f,-0.3f],angle:2.9f}}}
execute if score @s ch.v1 matches 2 run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{left_rotation:{axis:[1f,0f,0f],angle:2.7f}}}
