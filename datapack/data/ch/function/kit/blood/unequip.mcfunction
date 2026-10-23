# Blood stopped being active: removes its modifiers and ends Siphon tethers it holds.
attribute @s minecraft:armor modifier remove ch:blood_tol
attribute @s minecraft:armor_toughness modifier remove ch:blood_tol
scoreboard players set @s ch.blood.tol 0
scoreboard players set @s ch.blood.sip 0
scoreboard players set @s ch.blood.moon 0
scoreboard players set @s ch.meter 0
