# Growing: every 2 ticks the Titan grows one of five steps toward full Colossus size.
scoreboard players remove @s ch.titan.grow 1
scoreboard players operation #ti_m ch.tmp = @s ch.titan.grow
scoreboard players operation #ti_m ch.tmp %= #2 ch.g
execute unless score #ti_m ch.tmp matches 0 run return 0
scoreboard players add @s ch.titan.gst 1
scoreboard players set #ti_v ch.tmp 600
execute if score @s ch.awake matches 1 run scoreboard players set #ti_v ch.tmp 1000
execute if score @s ch.titan.colm matches 2 run scoreboard players add #ti_v ch.tmp 200
scoreboard players operation #ti_v ch.tmp *= @s ch.titan.gst
scoreboard players operation #ti_v ch.tmp /= #5 ch.titan.k
execute store result storage ch:tmp ti.v double 0.001 run scoreboard players get #ti_v ch.tmp
attribute @s minecraft:scale modifier remove ch:titan_colossus
function ch:kit/titan/col/scale with storage ch:tmp ti
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.6 1 0.6 0.1 20
playsound minecraft:entity.iron_golem.step player @a ~ ~ ~ 1.2 0.5
