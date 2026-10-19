scoreboard players add @s ch.v1 1
execute if score @s ch.v1 matches 2.. run scoreboard players set @s ch.v1 0
execute if score @s ch.v1 matches 0 run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{scale:[6.4f,6.0f,6.4f],left_rotation:{axis:[0f,1f,0f],angle:1.2f}}}
execute if score @s ch.v1 matches 1 run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{scale:[5.6f,5.9f,5.6f],left_rotation:{axis:[0f,1f,0f],angle:-1.2f}}}
