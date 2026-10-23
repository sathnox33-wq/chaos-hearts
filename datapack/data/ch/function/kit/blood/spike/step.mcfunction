# Blood Spike in flight: a dripping blood trail.
particle minecraft:dust{color:[0.62,0.04,0.12],scale:1.3} ~ ~ ~ 0.05 0.05 0.05 0 3
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~ ~ 0.05 0.05 0.05 0 1
execute if entity @s[tag=ch.blood.lance] run particle minecraft:dust{color:[1.0,0.18,0.25],scale:2.2} ~ ~ ~ 0.15 0.15 0.15 0 4
