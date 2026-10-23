# Crimson Eclipse, at its anchor: blood falls across 14 blocks; each second enemies inside bleed and are shrouded.
execute if score #r4 ch.tmp matches 0 run particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~10 ~ 7 0.5 7 0 20
execute if score #r4 ch.tmp matches 2 run particle minecraft:dust{color:[0.17,0.0,0.02],scale:2.5} ~ ~2 ~ 7 1.5 7 0 16
execute if score #t20 ch.g matches 0 run function ch:kit/blood/moon/eclipse_pulse
