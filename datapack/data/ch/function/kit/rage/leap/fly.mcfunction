# Leap flight, every tick: trail, landing marker, Skyfall apex and the slam on touchdown.
scoreboard players remove @s ch.rage.leap 1
execute unless predicate ch:on_ground run scoreboard players set @s ch.rage.air 1
execute if score @s ch.rage.air matches 1 if predicate ch:on_ground run return run function ch:kit/rage/leap/land
execute if score @s ch.rage.leap matches 0 run return run function ch:kit/rage/leap/end
particle minecraft:dust_color_transition{from_color:[1.0,0.42,0.12],to_color:[0.23,0.0,0.0],scale:1.6} ~ ~0.8 ~ 0.25 0.4 0.25 0 6
particle minecraft:flame ~ ~0.2 ~ 0.15 0.1 0.15 0.01 2
execute if score @s ch.rage.lap matches 0 if score @s ch.rage.air matches 1 if score @s ch.rage.lv matches 1.. run function ch:kit/rage/leap/apex_check
execute if score @s ch.rage.hang matches 1.. run function ch:kit/rage/leap/hang
scoreboard players set #sd ch.tmp 32
execute if score @s ch.rage.air matches 1 if score #r2 ch.tmp matches 0 run function ch:kit/rage/leap/seek
