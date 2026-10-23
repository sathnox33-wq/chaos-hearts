# Titan stops being active: every Titan modifier and form ends at once.
attribute @s minecraft:max_health modifier remove ch:titan_health
attribute @s minecraft:knockback_resistance modifier remove ch:titan_kb
attribute @s minecraft:armor modifier remove ch:titan_bulwark
attribute @s minecraft:armor_toughness modifier remove ch:titan_bulwark
attribute @s minecraft:fall_damage_multiplier modifier remove ch:titan_fall
scoreboard players set @s ch.titan.hp -1
scoreboard players set @s ch.titan.bw 0
scoreboard players set @s ch.titan.air 0
scoreboard players set @s ch.titan.fall 0
execute if score @s ch.titan.skin matches 1.. run function ch:kit/titan/skin/end
scoreboard players set @s ch.titan.skin 0
execute if score @s ch.titan.col matches 1.. run function ch:kit/titan/col/end
scoreboard players set @s ch.titan.col 0
scoreboard players set @s ch.meter 0
