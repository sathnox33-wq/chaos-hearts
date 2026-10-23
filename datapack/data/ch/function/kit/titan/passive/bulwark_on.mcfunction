# Bulwark hardens: armor plates of stone close over the Titan.
scoreboard players set @s ch.titan.bw 1
attribute @s minecraft:armor modifier add ch:titan_bulwark 4 add_value
attribute @s minecraft:armor_toughness modifier add ch:titan_bulwark 2 add_value
particle minecraft:block{block_state:"minecraft:polished_granite"} ~ ~1 ~ 0.35 0.6 0.35 0.05 25
particle minecraft:dust{color:[0.788,0.643,0.361],scale:1.2} ~ ~1 ~ 0.4 0.6 0.4 0 15
playsound minecraft:block.stone.place player @a ~ ~ ~ 1 0.5
playsound minecraft:block.anvil.place player @s ~ ~ ~ 0.3 0.6
