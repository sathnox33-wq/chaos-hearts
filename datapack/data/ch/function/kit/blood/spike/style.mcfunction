# Restyles a new spike projectile: a glowing crimson spike model pointing along its flight.
tag @s add ch.blood.sp
data modify entity @s item.components."minecraft:item_model" set value "chaoshearts:fx/spike"
data modify entity @s item.components."minecraft:custom_model_data" set value {colors:[16723263]}
data merge entity @s {transformation:{left_rotation:{axis:[1f,0f,0f],angle:1.5708f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,-0.4f],scale:[0.7f,1.3f,0.7f]}}
