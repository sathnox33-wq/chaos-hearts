# Speed stopped being active: removes its modifiers and ends anything that rides on the player.
attribute @s minecraft:movement_speed modifier remove ch:speed_swift
attribute @s minecraft:armor modifier remove ch:speed_slippery
execute if score @s ch.speed.van matches 1.. run function ch:kit/speed/van/reveal
scoreboard players set @s ch.speed.slip 0
scoreboard players set @s ch.speed.spr 0
scoreboard players set @s ch.meter 0
