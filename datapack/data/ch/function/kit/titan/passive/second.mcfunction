# Once a second: Mountain's Endurance (+2 hearts, +1 awakened, +1 Granite, 30% knockback resistance) and Tremor decay.
scoreboard players set #ti_hp ch.tmp 4
execute if score @s ch.awake matches 1 run scoreboard players add #ti_hp ch.tmp 2
execute if score @s ch.b2 matches 1.. run scoreboard players add #ti_hp ch.tmp 2
execute unless score @s ch.titan.hp = #ti_hp ch.tmp run function ch:kit/titan/passive/health
attribute @s minecraft:knockback_resistance modifier add ch:titan_kb 0.3 add_value
scoreboard players operation #ti_age ch.tmp = #now ch.g
scoreboard players operation #ti_age ch.tmp -= @s ch.titan.lt
execute if score #ti_age ch.tmp matches 120.. if score @s ch.titan.trem matches 1.. run scoreboard players remove @s ch.titan.trem 3
execute if score @s ch.titan.trem matches ..-1 run scoreboard players set @s ch.titan.trem 0
