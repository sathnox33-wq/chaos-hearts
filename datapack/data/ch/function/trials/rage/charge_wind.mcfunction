# Charge windup ticking: pawing the ground, the lane glowing, then the charge.
scoreboard players remove @s ch.v3 1
execute if score @s ch.v3 matches 0..19 run particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.2 ~ 0.8 0.1 0.8 0.1 4
scoreboard players operation #m ch.tmp = @s ch.v3
scoreboard players operation #m ch.tmp %= #4 ch.g
scoreboard players set #ln ch.tmp 20
execute if score #m ch.tmp matches 0 rotated as @e[type=marker,tag=ch.rage.bdir,distance=..2,limit=1] positioned ~ ~0.2 ~ run function ch:trials/rage/lane
execute if score @s ch.v3 matches ..0 run function ch:trials/rage/charge_go
