# The falling moon drops one block a tick, trailing blood; at the end it lands.
scoreboard players remove @s ch.life 1
tp @s ~ ~-1 ~
particle minecraft:dust{color:[0.62,0.04,0.12],scale:3.0} ~ ~1 ~ 1 1 1 0 12
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~ ~ 1.5 1 1.5 0 6
particle minecraft:large_smoke ~ ~2 ~ 0.6 0.6 0.6 0.02 3
execute if score @s ch.life matches 10 run playsound minecraft:entity.wither.shoot player @a ~ ~ ~ 2 0.4
execute if score @s ch.life matches ..0 at @s run function ch:kit/blood/moon/impact
