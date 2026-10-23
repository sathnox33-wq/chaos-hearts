# A blow lands on the sanctuary: 85% of it is restored, one fewer hit to break it.
scoreboard players operation #ce_dh ch.tmp = @s ch.v5
scoreboard players operation #ce_dh ch.tmp -= #ce_h ch.tmp
scoreboard players operation #ce_dh ch.tmp *= #3 ch.celestial.k
scoreboard players operation #ce_dh ch.tmp /= #20 ch.g
scoreboard players operation @s ch.v5 -= #ce_dh ch.tmp
execute store result entity @s Health float 0.1 run scoreboard players get @s ch.v5
scoreboard players remove @s ch.v4 1
particle minecraft:end_rod ~ ~1.5 ~ 1.5 1.5 1.5 0.1 20
playsound minecraft:block.amethyst_block.hit master @a ~ ~ ~ 2 1.4
execute if score @s ch.v4 matches 1.. run function ch:trials/celestial/callout {m:"The sanctuary shudders..."}
execute if score @s ch.v4 matches 0 run function ch:trials/celestial/shield_break
