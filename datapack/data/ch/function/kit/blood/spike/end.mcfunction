# Blood Spike shatters against a wall or runs out.
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~ ~ 0.25 0.25 0.25 0.15 20
particle minecraft:dust{color:[0.62,0.04,0.12],scale:1.8} ~ ~ ~ 0.3 0.3 0.3 0 15
playsound minecraft:block.pointed_dripstone.land player @a ~ ~ ~ 1 0.8
playsound minecraft:entity.slime.squish_small player @a ~ ~ ~ 1 0.6
