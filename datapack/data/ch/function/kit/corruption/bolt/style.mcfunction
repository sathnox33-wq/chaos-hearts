# As the new bolt, caster tagged: restyle it as a sickly green orb and snapshot its payload.
data modify entity @s item.components."minecraft:item_model" set value "chaoshearts:fx/orb"
data modify entity @s item.components."minecraft:custom_model_data" set value {colors:[8114490]}
data merge entity @s {brightness:{sky:15,block:15}}
scoreboard players operation @s ch.v4 = #cd ch.tmp
scoreboard players operation @s ch.v2 = #cpest ch.tmp
scoreboard players operation @s ch.v6 = #cnec ch.tmp
scoreboard players set @s ch.v5 30
execute if entity @a[tag=ch.caster,scores={ch.b1=2..},limit=1] run scoreboard players set @s ch.v5 42
execute if score #cpest ch.tmp matches 1 run scoreboard players operation @s ch.v5 *= #3 ch.corruption.k
execute if score #cpest ch.tmp matches 1 run scoreboard players operation @s ch.v5 /= #2 ch.g
execute if score #cvar ch.tmp matches 1 run tag @s add ch.corruption.mortar
execute if score #cvar ch.tmp matches 1 run scoreboard players operation @s ch.v5 *= #13 ch.corruption.k
execute if score #cvar ch.tmp matches 1 run scoreboard players operation @s ch.v5 /= #10 ch.g
scoreboard players set @s ch.v3 80
execute if entity @a[tag=ch.caster,scores={ch.b1=3..},limit=1] run scoreboard players set @s ch.v3 120
execute if entity @a[tag=ch.caster,scores={ch.b1=5..},limit=1] run tag @s add ch.corruption.rain
