# As one display layer: its next spin and size.
$execute if score @s ch.v1 matches 0 run data merge entity @s {start_interpolation:0,interpolation_duration:5,transformation:{right_rotation:{axis:[0f,1f,0f],angle:$(a)f},scale:[$(s)f,$(s)f,$(s)f]}}
$execute if score @s ch.v1 matches 1 run data merge entity @s {start_interpolation:0,interpolation_duration:5,transformation:{right_rotation:{axis:[0f,1f,0f],angle:$(a)f},scale:[$(s2)f,$(s2)f,$(s2)f]}}
$execute if score @s ch.v1 matches 2 run data merge entity @s {start_interpolation:0,interpolation_duration:5,transformation:{right_rotation:{axis:[0f,1f,0f],angle:$(b)f},scale:[$(s3)f,$(s3)f,$(s3)f]}}
$execute if score @s ch.v1 matches 3 run data merge entity @s {start_interpolation:0,interpolation_duration:5,transformation:{right_rotation:{axis:[0f,1f,0f],angle:$(b)f},scale:[$(s4)f,$(s4)f,$(s4)f]}}
