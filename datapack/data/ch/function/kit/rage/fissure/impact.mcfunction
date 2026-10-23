# The fist hits the ground where the fissure starts.
function ch:api/fx/wave {color:14689835,r:2.5,t:4}
particle minecraft:explosion ~ ~0.3 ~ 0.2 0.1 0.2 0 1
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.2 ~ 0.6 0.1 0.6 0.2 30
function ch:api/fx/shake {s:2,t:5,r:8}
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.2 0.8
playsound chaoshearts:rage_slam player @a ~ ~ ~ 1 1.3
