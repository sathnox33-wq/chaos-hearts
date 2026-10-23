# Titan holder was hurt: Tremor builds; Spiked Stone hurts the attacker while Stone Skin holds.
scoreboard players add @s ch.titan.trem 6
scoreboard players operation @s ch.titan.lt = #now ch.g
execute if score @s ch.titan.skin matches 1.. if score @s ch.b2 matches 3.. unless score @s ch.titan.thcd matches 1.. run function ch:kit/titan/skin/thorns
