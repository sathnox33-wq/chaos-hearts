scoreboard players add @s ch.v1 1
execute if score @s ch.v1 matches 3.. run scoreboard players set @s ch.v1 0
execute if score @s ch.v1 matches 0 as @e[type=item_display,tag=ch.altar_crystal,distance=..4,limit=1] run data merge entity @s {start_interpolation:0,interpolation_duration:40,transformation:{left_rotation:{axis:[0f,1f,0f],angle:0f},translation:[0f,0.25f,0f]}}
execute if score @s ch.v1 matches 1 as @e[type=item_display,tag=ch.altar_crystal,distance=..4,limit=1] run data merge entity @s {start_interpolation:0,interpolation_duration:40,transformation:{left_rotation:{axis:[0f,1f,0f],angle:2.0944f},translation:[0f,-0.1f,0f]}}
execute if score @s ch.v1 matches 2 as @e[type=item_display,tag=ch.altar_crystal,distance=..4,limit=1] run data merge entity @s {start_interpolation:0,interpolation_duration:40,transformation:{left_rotation:{axis:[0f,1f,0f],angle:4.1888f},translation:[0f,0.15f,0f]}}
execute if score @s ch.v1 matches 0 as @e[type=item_display,tag=ch.altar_rune,distance=..4,limit=1] run data merge entity @s {start_interpolation:0,interpolation_duration:40,transformation:{left_rotation:{axis:[0f,1f,0f],angle:0f}}}
execute if score @s ch.v1 matches 1 as @e[type=item_display,tag=ch.altar_rune,distance=..4,limit=1] run data merge entity @s {start_interpolation:0,interpolation_duration:40,transformation:{left_rotation:{axis:[0f,1f,0f],angle:-2.0944f}}}
execute if score @s ch.v1 matches 2 as @e[type=item_display,tag=ch.altar_rune,distance=..4,limit=1] run data merge entity @s {start_interpolation:0,interpolation_duration:40,transformation:{left_rotation:{axis:[0f,1f,0f],angle:-4.1888f}}}
execute as @e[type=item_display,tag=ch.altar_gem,distance=..4] at @s run tp @s ~ ~ ~ ~40 ~
scoreboard players add @s ch.v2 1
execute if score @s ch.v2 matches 2.. run playsound chaoshearts:altar_hum ambient @a[distance=..20] ~ ~ ~ 0.7 1
execute if score @s ch.v2 matches 2.. run scoreboard players set @s ch.v2 0
