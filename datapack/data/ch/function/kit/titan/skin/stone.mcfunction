# Level Stone Skin: 5 s (7 with Enduring Stone) of Resistance II, no knockback, slowed unless Unshakable.
scoreboard players set @s ch.titan.skm 0
scoreboard players set @s ch.titan.skin 100
execute if score @s ch.b2 matches 2.. run scoreboard players set @s ch.titan.skin 140
execute unless score @s ch.b2 matches 2.. run effect give @s minecraft:resistance 5 1 true
execute if score @s ch.b2 matches 2.. run effect give @s minecraft:resistance 7 1 true
execute unless score @s ch.b2 matches 2.. unless score @s ch.b2 matches 4.. run effect give @s minecraft:slowness 5 0 true
execute if score @s ch.b2 matches 2..3 run effect give @s minecraft:slowness 7 0 true
attribute @s minecraft:knockback_resistance modifier add ch:titan_skin 1 add_value
execute if score @s ch.b2 matches 5.. run function ch:kit/titan/skin/fortress
function ch:kit/titan/skin/form_fx
return 1
