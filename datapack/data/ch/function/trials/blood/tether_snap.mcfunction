# The tether snaps.
scoreboard players set @s ch.v3 0
execute at @a[tag=ch.challenger,distance=..40,limit=1] run particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.4 0.4 0.4 0.3 20
playsound minecraft:block.glass.break master @a[distance=..90] ~ ~ ~ 1.4 0.6
function ch:trials/blood/say {m:"The tether snaps."}
