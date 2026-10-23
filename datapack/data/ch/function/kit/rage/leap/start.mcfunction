# Shared leap start: flight timer, no fall damage, launch dust.
scoreboard players set @s ch.rage.air 0
scoreboard players set @s ch.rage.lap 0
scoreboard players set @s ch.rage.hang 0
scoreboard players set @s ch.rage.safe 0
attribute @s minecraft:fall_damage_multiplier modifier remove ch:rage_safe
attribute @s minecraft:fall_damage_multiplier modifier add ch:rage_safe -1 add_multiplied_total
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.2 ~ 0.6 0.1 0.6 0.2 24
particle minecraft:cloud ~ ~0.2 ~ 0.4 0.05 0.4 0.08 12
function ch:api/fx/wave {color:14689835,r:2.5,t:5}
playsound chaoshearts:rage_leap player @a ~ ~ ~ 1.2 1
playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 1 0.6
