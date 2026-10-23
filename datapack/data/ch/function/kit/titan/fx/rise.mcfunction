# A buried slab heaves up out of the ground, tilted a little.
tag @s remove ch.titan.anew
execute if entity @s[tag=!ch.titan.big] if score @s ch.v1 matches 0 run data merge entity @s {start_interpolation:0,interpolation_duration:3,transformation:{translation:[-0.45f,-0.3f,-0.45f],left_rotation:[0.1219f,0f,0f,0.9925f]}}
execute if entity @s[tag=ch.titan.big] if score @s ch.v1 matches 0 run data merge entity @s {start_interpolation:0,interpolation_duration:3,transformation:{translation:[-0.7f,-0.4f,-0.7f],left_rotation:[0.1219f,0f,0f,0.9925f]}}
execute if entity @s[tag=!ch.titan.big] if score @s ch.v1 matches 1 run data merge entity @s {start_interpolation:0,interpolation_duration:3,transformation:{translation:[-0.45f,-0.3f,-0.45f],left_rotation:[-0.1219f,0f,0f,0.9925f]}}
execute if entity @s[tag=ch.titan.big] if score @s ch.v1 matches 1 run data merge entity @s {start_interpolation:0,interpolation_duration:3,transformation:{translation:[-0.7f,-0.4f,-0.7f],left_rotation:[-0.1219f,0f,0f,0.9925f]}}
execute if entity @s[tag=!ch.titan.big] if score @s ch.v1 matches 2 run data merge entity @s {start_interpolation:0,interpolation_duration:3,transformation:{translation:[-0.45f,-0.3f,-0.45f],left_rotation:[0f,0f,0.1219f,0.9925f]}}
execute if entity @s[tag=ch.titan.big] if score @s ch.v1 matches 2 run data merge entity @s {start_interpolation:0,interpolation_duration:3,transformation:{translation:[-0.7f,-0.4f,-0.7f],left_rotation:[0f,0f,0.1219f,0.9925f]}}
execute if entity @s[tag=!ch.titan.big] if score @s ch.v1 matches 3 run data merge entity @s {start_interpolation:0,interpolation_duration:3,transformation:{translation:[-0.45f,-0.3f,-0.45f],left_rotation:[0f,0f,-0.1219f,0.9925f]}}
execute if entity @s[tag=ch.titan.big] if score @s ch.v1 matches 3 run data merge entity @s {start_interpolation:0,interpolation_duration:3,transformation:{translation:[-0.7f,-0.4f,-0.7f],left_rotation:[0f,0f,-0.1219f,0.9925f]}}
