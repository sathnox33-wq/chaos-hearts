# The fire halo on Gorrath's back turns one step (#q ch.tmp 0..7), interpolated over 5 ticks.
data modify entity @s start_interpolation set value 0
execute if score #q ch.tmp matches 0 run data modify entity @s transformation.left_rotation set value [0f,0.00000f,0f,1.00000f]
execute if score #q ch.tmp matches 1 run data modify entity @s transformation.left_rotation set value [0f,0.38268f,0f,0.92388f]
execute if score #q ch.tmp matches 2 run data modify entity @s transformation.left_rotation set value [0f,0.70711f,0f,0.70711f]
execute if score #q ch.tmp matches 3 run data modify entity @s transformation.left_rotation set value [0f,0.92388f,0f,0.38268f]
execute if score #q ch.tmp matches 4 run data modify entity @s transformation.left_rotation set value [0f,1.00000f,0f,0.00000f]
execute if score #q ch.tmp matches 5 run data modify entity @s transformation.left_rotation set value [0f,0.92388f,0f,-0.38268f]
execute if score #q ch.tmp matches 6 run data modify entity @s transformation.left_rotation set value [0f,0.70711f,0f,-0.70711f]
execute if score #q ch.tmp matches 7 run data modify entity @s transformation.left_rotation set value [0f,0.38268f,0f,-0.92388f]
