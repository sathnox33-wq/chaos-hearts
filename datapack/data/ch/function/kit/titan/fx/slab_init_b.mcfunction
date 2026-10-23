# A new big earth slab: starts buried, rises next tick, sinks and fades.
$data merge entity @s {block_state:{Name:"$(b)"},Tags:["ch.fx","ch.noability","ch.titan.slab","ch.titan.anew","ch.titan.big"],view_range:1.5f,interpolation_duration:3,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.7f,-1.45f,-0.7f],scale:[1.4f,1.4f,1.4f]}}
scoreboard players set @s ch.life 18
scoreboard players operation @s ch.t = #now ch.g
scoreboard players operation @s ch.v1 = #now ch.g
scoreboard players operation @s ch.v1 %= #4 ch.g
execute rotated ~ 0 run tp @s ~ ~ ~ ~ 0
scoreboard players set #fx ch.g 1
