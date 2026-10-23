# Mastery 90 aura (every 4 ticks): embers around the feet and blood dripping from the cracked heart.
particle minecraft:dust{color:[0.88,0.15,0.17],scale:0.8} ~ ~0.1 ~ 0.45 0.05 0.45 0 2
particle minecraft:small_flame ~ ~0.15 ~ 0.4 0.05 0.4 0.005 1
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.3 ~ 0.15 0.1 0.15 0 1
execute if score @s ch.awake matches 1 run particle minecraft:lava ~ ~0.2 ~ 0.3 0 0.3 0 1
