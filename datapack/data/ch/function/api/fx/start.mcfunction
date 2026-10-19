tag @s remove ch.fxwait
execute if entity @s[type=text_display] run return run data merge entity @s {start_interpolation:0,interpolation_duration:20,transformation:{translation:[0f,1.4f,0f],scale:[1.3f,1.3f,1.3f]}}
data modify entity @s transformation set from entity @s item.components."minecraft:custom_data".to
data modify entity @s start_interpolation set value 0
