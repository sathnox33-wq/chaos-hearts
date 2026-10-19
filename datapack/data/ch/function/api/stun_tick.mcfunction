scoreboard players remove @s ch.stun 1
scoreboard players set #stuns ch.g 1
execute if score #t20 ch.g matches 0 run particle minecraft:dust{color:[1.0,0.9,0.3],scale:0.8} ~ ~2.1 ~ 0.25 0.05 0.25 0 4
execute if score @s ch.stun matches 1.. run return 0
attribute @s minecraft:movement_speed modifier remove ch:stun
attribute @s minecraft:jump_strength modifier remove ch:stun
