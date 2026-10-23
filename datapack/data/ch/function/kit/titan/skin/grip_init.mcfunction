# Grip block: lasts 42 ticks (the slab sink runs at 9 ticks left, then it fades).
$data merge entity @s {block_state:{Name:"$(b)"},Tags:["ch.fx","ch.noability","ch.titan.slab"],interpolation_duration:3,view_range:1.5f,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.6f,-0.1f,-0.6f],scale:[1.2f,0.9f,1.2f]}}
scoreboard players set @s ch.life 42
scoreboard players set #fx ch.g 1
