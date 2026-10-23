# The locked beam: a guide line for 26 ticks, then 10 ticks of burning light that hits once for 9.
scoreboard players remove @s ch.life 1
scoreboard players set #ce_n ch.tmp 0
scoreboard players set #ce_hitp ch.tmp 0
scoreboard players operation #ce_m ch.tmp = @s ch.life
scoreboard players operation #ce_m ch.tmp %= #2 ch.g
execute if score @s ch.life matches 11.. if score #ce_m ch.tmp matches 0 run function ch:trials/celestial/tb_march {p:"minecraft:dust{color:[1.0,0.79,0.29],scale:0.7}"}
execute if score @s ch.life matches 11 run playsound minecraft:block.beacon.activate master @a ~ ~ ~ 2 2
execute if score @s ch.life matches ..10 run function ch:trials/celestial/tb_march {p:"minecraft:end_rod"}
execute if score @s ch.life matches ..10 store result storage ch:tmp cb.len float 0.5 run scoreboard players get #ce_n ch.tmp
execute if score @s ch.life matches 10 run function ch:trials/celestial/tb_draw with storage ch:tmp cb
execute if score @s ch.life matches 5 run function ch:trials/celestial/tb_draw with storage ch:tmp cb
execute if score @s ch.life matches ..10 if score #ce_hitp ch.tmp matches 1 if score @s ch.v1 matches 0 run function ch:trials/celestial/tb_hit
execute if score @s ch.life matches ..0 run kill @s
