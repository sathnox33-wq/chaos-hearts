# A rain pool: falls for 11 s; after a 1 s warning it drains anyone inside (2 a second) and heals Vesperine.
scoreboard players remove @s ch.life 1
execute if score #r2 ch.tmp matches 0 run particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~6 ~ 3 0.3 3 0 8
execute if score #r2 ch.tmp matches 1 run particle minecraft:dripping_dripstone_lava ~ ~6 ~ 3 0.3 3 0 4
execute if score @s ch.life matches ..0 run return run kill @s
execute if score @s ch.life matches 200.. run return 0
scoreboard players operation #m ch.tmp = @s ch.life
scoreboard players operation #m ch.tmp %= #20 ch.g
execute if score #m ch.tmp matches 0 if entity @a[tag=ch.challenger,distance=..4,limit=1] run function ch:trials/blood/zone_drain
