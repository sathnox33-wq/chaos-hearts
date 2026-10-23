# Volley, down: 8 embers (12 with Extra Fuel) spiral out from you, one per tick: a close-range wheel of fire.
scoreboard players set #i_n ch.tmp 8
scoreboard players set #i_st ch.tmp 45
execute if score @s ch.b1 matches 2.. run scoreboard players set #i_n ch.tmp 12
execute if score @s ch.b1 matches 2.. run scoreboard players set #i_st ch.tmp 30
execute store result score #i_yaw ch.tmp run data get entity @s Rotation[0]
scoreboard players set #i_k ch.tmp 0
function ch:kit/infernal/volley/pin_shot
scoreboard players set #i_k ch.tmp 1
function ch:kit/infernal/volley/pin_queue
execute rotated 0 0 run function ch:kit/infernal/volley/pin_fx with storage ch:tmp ki
return 1
