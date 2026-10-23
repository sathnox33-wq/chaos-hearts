# Mastery 90 aura (every 4 ticks): blood drips from you and crimson spores drift.
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.2 ~ 0.35 0.4 0.35 0 1
particle minecraft:crimson_spore ~ ~1 ~ 0.5 0.6 0.5 0 2
execute if score @s ch.awake matches 1 run particle minecraft:dust{color:[0.17,0.0,0.02],scale:1.2} ~ ~0.1 ~ 0.45 0.02 0.45 0 2
