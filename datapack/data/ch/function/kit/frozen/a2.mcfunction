# Glacial Wall. Level: a wall of solid ice ahead. Up: Glacier Ram, a moving wall that bulldozes forward. Down: Frozen Bastion, a ring of ice pillars and Resistance II.
scoreboard players operation #f_var ch.tmp = #var ch.tmp
scoreboard players set #f_dur ch.tmp 160
execute if score @s ch.b1 matches 2.. run scoreboard players set #f_dur ch.tmp 224
playsound chaoshearts:frozen_wall player @a ~ ~ ~ 1.4 1
playsound minecraft:block.glass.place player @a ~ ~ ~ 1.2 0.6
playsound minecraft:block.powder_snow.place player @a ~ ~ ~ 1.2 0.6
execute rotated 0 0 run function ch:api/fx/wave {color:10217471,r:3.0,t:5}
execute if score #f_var ch.tmp matches 1 run return run function ch:kit/frozen/wall/ram
execute if score #f_var ch.tmp matches 2 run return run function ch:kit/frozen/wall/bastion
return run function ch:kit/frozen/wall/line
