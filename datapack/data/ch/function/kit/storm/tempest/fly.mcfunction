# Ride the Lightning: hold Jump to rise, Sneak to drop, otherwise you glide.
execute if predicate ch:input/jump run effect give @s minecraft:levitation 1 3 true
execute unless predicate ch:input/jump run effect clear @s minecraft:levitation
execute unless predicate ch:input/jump unless predicate ch:input/sneak run effect give @s minecraft:slow_falling 1 0 true
execute if predicate ch:input/sneak run effect clear @s minecraft:slow_falling
execute if predicate ch:input/jump run particle minecraft:electric_spark ~ ~ ~ 0.3 0.1 0.3 0.1 4
