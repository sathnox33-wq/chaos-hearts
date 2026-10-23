# One bleeding entity, every tick: dripping blood, a wound every second.
scoreboard players remove @s ch.blood.bleed 1
scoreboard players set #bleeds ch.blood.g 1
execute if score #r2 ch.tmp matches 0 run particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.2 ~ 0.25 0.35 0.25 0 1
scoreboard players operation #m ch.tmp = @s ch.blood.bleed
scoreboard players operation #m ch.tmp %= #20 ch.g
execute if score #m ch.tmp matches 0 run function ch:kit/blood/bleed/wound
execute if score @s ch.blood.bleed matches ..0 run scoreboard players reset @s ch.blood.bo
