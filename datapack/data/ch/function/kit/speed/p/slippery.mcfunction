# Slippery: about 10% less damage while sprinting (extra armour only while you sprint).
execute if predicate ch:sprinting run attribute @s minecraft:armor modifier add ch:speed_slippery 3 add_value
execute unless predicate ch:sprinting run attribute @s minecraft:armor modifier remove ch:speed_slippery
