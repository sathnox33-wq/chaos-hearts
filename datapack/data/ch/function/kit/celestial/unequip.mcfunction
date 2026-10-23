# Celestial stops being active: flight, channels and the halo end.
effect clear @s minecraft:night_vision
execute if score @s ch.celestial.asc matches 1.. run function ch:kit/celestial/asc/end
scoreboard players set @s ch.celestial.asc 0
scoreboard players set @s ch.celestial.bm 0
attribute @s minecraft:gravity modifier remove ch:celestial_hover
attribute @s minecraft:movement_speed modifier remove ch:celestial_channel
scoreboard players operation #ce_pid ch.tmp = @s ch.pid
execute as @e[type=item_display,tag=ch.celestial.follow,distance=..8] if score @s ch.owner = #ce_pid ch.tmp run kill @s
scoreboard players set @s ch.meter 0
