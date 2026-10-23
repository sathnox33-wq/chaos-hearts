# Dawnbreaker, every tick: draws the beam every 2 ticks, burns every 10, and ends after 50 ticks.
scoreboard players remove @s ch.celestial.bm 1
effect give @s minecraft:slowness 1 3 true
scoreboard players operation #ce_m ch.tmp = @s ch.celestial.bm
scoreboard players operation #ce_m ch.tmp %= #2 ch.g
execute if score #ce_m ch.tmp matches 0 run function ch:kit/celestial/beam/ch_draw
scoreboard players operation #ce_m ch.tmp = @s ch.celestial.bm
scoreboard players operation #ce_m ch.tmp %= #10 ch.g
execute if score #ce_m ch.tmp matches 0 run function ch:kit/celestial/beam/ch_burn
execute if score @s ch.celestial.bm matches 0 run playsound minecraft:block.beacon.deactivate player @a ~ ~ ~ 1 1.6
