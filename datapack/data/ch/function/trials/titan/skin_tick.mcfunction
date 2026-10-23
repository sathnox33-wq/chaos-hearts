# While Golgoth's skin holds: stone flakes off it; when it cracks, a burst of shards.
scoreboard players remove @s ch.v4 1
execute if score #t20 ch.g matches 0..19 run particle minecraft:dust{color:[0.478,0.455,0.416],scale:1.6} ~ ~2.5 ~ 1.4 2 1.4 0 4
execute if score @s ch.v4 matches 0 run particle minecraft:block{block_state:"minecraft:stone"} ~ ~2.5 ~ 1.5 2 1.5 0.4 120
execute if score @s ch.v4 matches 0 run playsound minecraft:block.glass.break master @a ~ ~ ~ 2 0.5
execute if score @s ch.v4 matches 0 run function ch:trials/titan/callout {m:"The stone cracks! Strike now!"}
