# Pain Tolerance takes hold.
scoreboard players set @s ch.blood.tol 1
attribute @s minecraft:armor modifier add ch:blood_tol 2.5 add_value
attribute @s minecraft:armor_toughness modifier add ch:blood_tol 2 add_value
particle minecraft:dust{color:[0.17,0.0,0.02],scale:1.5} ~ ~1 ~ 0.3 0.5 0.3 0 12
