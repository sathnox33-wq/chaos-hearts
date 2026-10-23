# A tumbling chunk of $(b): flies 2.6 blocks outward over 6 ticks, then fades.
$data merge entity @s {block_state:{Name:"$(b)"},Tags:["ch.fx","ch.noability","ch.titan.slide"],teleport_duration:6,view_range:1.5f,transformation:{left_rotation:[0.2f,0.3f,0.1f,0.93f],right_rotation:[0f,0f,0f,1f],translation:[-0.2f,-0.2f,-0.2f],scale:[0.4f,0.4f,0.4f]}}
tp @s ~ ~ ~ ~ ~
scoreboard players set @s ch.v6 26
scoreboard players set @s ch.life 13
scoreboard players operation @s ch.t = #now ch.g
scoreboard players set #fx ch.g 1
