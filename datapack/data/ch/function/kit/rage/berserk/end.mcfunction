# Berserk ends.
scoreboard players set @s ch.rage.bz 0
scoreboard players set @s ch.rage.bzt 0
scoreboard players set @s ch.rage.bzm 0
scoreboard players set @s ch.rage.cnt 0
attribute @s minecraft:attack_damage modifier remove ch:rage_berserk
attribute @s minecraft:knockback_resistance modifier remove ch:rage_stance
particle minecraft:smoke ~ ~1 ~ 0.3 0.4 0.3 0.02 8
playsound minecraft:block.fire.extinguish player @s ~ ~ ~ 0.5 0.8
