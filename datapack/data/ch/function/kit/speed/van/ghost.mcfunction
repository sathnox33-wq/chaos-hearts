# Keeps the vaulted armour's protection while it is hidden.
attribute @s minecraft:armor modifier remove ch:speed_ghost
attribute @s minecraft:armor_toughness modifier remove ch:speed_ghost
$attribute @s minecraft:armor modifier add ch:speed_ghost $(a) add_value
$attribute @s minecraft:armor_toughness modifier add ch:speed_ghost $(t) add_value
