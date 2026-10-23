# Voltaris, every tick: crown and orbs follow; idle time picks the next storm pattern.
function ch:trials/storm/b/deco
execute if score #t3 ch.storm.g matches 0 run particle minecraft:electric_spark ~ ~2.5 ~ 0.8 1 0.8 0.05 4
execute if score @s ch.v1 matches 1.. run scoreboard players add @s ch.v2 1
execute if score @s ch.v1 matches 0 run scoreboard players add @s ch.v3 1
execute if score @s ch.v1 matches 0 run function ch:trials/storm/b/choose
execute if score @s ch.v1 matches 1 run function ch:trials/storm/b/call
execute if score @s ch.v1 matches 2 run function ch:trials/storm/b/chain
execute if score @s ch.v4 matches 2.. run scoreboard players add @s ch.v5 1
execute if score @s ch.v5 matches 240.. run function ch:trials/storm/b/static
execute if score @s ch.v4 matches 3.. run function ch:trials/storm/b/tempest
