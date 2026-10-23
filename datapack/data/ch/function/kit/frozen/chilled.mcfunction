# Chilled Blood: a heavy hit from a slowed attacker is about 10% mended.
execute store result score #f_now ch.tmp run data get entity @s Health 10
scoreboard players operation #f_dl ch.tmp = @s ch.frozen.hp
scoreboard players operation #f_dl ch.tmp -= #f_now ch.tmp
execute unless score #f_dl ch.tmp matches 40.. run return 0
scoreboard players set #f_sl ch.tmp 0
execute on attacker if data entity @s active_effects[{id:"minecraft:slowness"}] run scoreboard players set #f_sl ch.tmp 1
execute if score #f_sl ch.tmp matches 0 run return 0
effect give @s minecraft:regeneration 1 2 true
particle minecraft:snowflake ~ ~1 ~ 0.3 0.5 0.3 0.02 6
