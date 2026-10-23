# Titan holder killed something: counts kills for Giant's Wrath while a Colossus.
execute unless score @s ch.titan.col matches 1.. run return 0
scoreboard players add @s ch.titan.kills 1
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 0.8 0.7
execute if score @s ch.titan.kills matches 3.. run function ch:api/feat {h:"titan",n:3}
