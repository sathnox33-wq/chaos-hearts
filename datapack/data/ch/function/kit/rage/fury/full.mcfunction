# Fury just reached 100: Unchained feat progress and Bloodlust.
scoreboard players add @s ch.rage.maxn 1
execute if score @s ch.rage.maxn matches 10.. run function ch:api/feat {h:"rage",n:1}
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 0.5 1.6
particle minecraft:angry_villager ~ ~1.4 ~ 0.5 0.5 0.5 0 6
execute if score @s ch.lvl matches 25.. unless score @s ch.rage.bl matches 1.. run function ch:kit/rage/fury/bloodlust
