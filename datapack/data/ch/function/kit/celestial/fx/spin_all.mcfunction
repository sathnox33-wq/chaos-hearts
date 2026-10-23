# Every 10 ticks: all spinning Celestial displays turn another quarter (reverse ones the other way).
scoreboard players operation #ce_q ch.tmp = #now ch.g
scoreboard players operation #ce_q ch.tmp /= #10 ch.g
scoreboard players operation #ce_q ch.tmp %= #4 ch.g
execute if score #ce_q ch.tmp matches 0 as @e[type=item_display,tag=ch.celestial.spin,tag=!ch.celestial.rev] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{right_rotation:[0f,0f,0f,1f]}}
execute if score #ce_q ch.tmp matches 0 as @e[type=item_display,tag=ch.celestial.spin,tag=ch.celestial.rev] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{right_rotation:[0f,0f,0f,1f]}}
execute if score #ce_q ch.tmp matches 1 as @e[type=item_display,tag=ch.celestial.spin,tag=!ch.celestial.rev] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{right_rotation:[0f,0.7071f,0f,0.7071f]}}
execute if score #ce_q ch.tmp matches 1 as @e[type=item_display,tag=ch.celestial.spin,tag=ch.celestial.rev] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{right_rotation:[0f,0.7071f,0f,-0.7071f]}}
execute if score #ce_q ch.tmp matches 2 as @e[type=item_display,tag=ch.celestial.spin,tag=!ch.celestial.rev] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{right_rotation:[0f,1f,0f,0f]}}
execute if score #ce_q ch.tmp matches 2 as @e[type=item_display,tag=ch.celestial.spin,tag=ch.celestial.rev] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{right_rotation:[0f,1f,0f,0f]}}
execute if score #ce_q ch.tmp matches 3 as @e[type=item_display,tag=ch.celestial.spin,tag=!ch.celestial.rev] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{right_rotation:[0f,0.7071f,0f,-0.7071f]}}
execute if score #ce_q ch.tmp matches 3 as @e[type=item_display,tag=ch.celestial.spin,tag=ch.celestial.rev] run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{right_rotation:[0f,0.7071f,0f,0.7071f]}}
