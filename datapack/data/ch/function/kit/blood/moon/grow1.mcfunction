# Swells one moon piece (orb 4.5, ring 7, halo 9).
tag @s add ch.blood.grown
data modify entity @s start_interpolation set value 0
execute if items entity @s contents *[minecraft:item_model="chaoshearts:fx/orb"] run data modify entity @s transformation.scale set value [4.5f,4.5f,4.5f]
execute if items entity @s contents *[minecraft:item_model="chaoshearts:fx/ring"] run data modify entity @s transformation.scale set value [7f,7f,7f]
execute if items entity @s contents *[minecraft:item_model="chaoshearts:fx/ring_soft"] run data modify entity @s transformation.scale set value [9f,1f,9f]
