# The free Avalanche recast: afterwards the original cooldown continues.
scoreboard players set @s ch.rage.ava 0
scoreboard players operation @s ch.cd1 = @s ch.rage.avcd
execute if score @s ch.cd1 matches ..0 run scoreboard players set @s ch.cd1 1
