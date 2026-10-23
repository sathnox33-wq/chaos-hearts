# Crimson Pact running: blood mist and dripping wounds; a rotating rune ward while Blood Ward holds.
scoreboard players remove @s ch.blood.pact 1
execute if score #r4 ch.tmp matches 0 run particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.1} ~ ~1 ~ 0.3 0.5 0.3 0 2
execute if score #r4 ch.tmp matches 2 run particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.3 ~ 0.25 0.2 0.25 0 1
execute if score @s ch.blood.pv matches 1 if score #r4 ch.tmp matches 0 positioned ~ ~1 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[0.62,0.04,0.12],scale:0.9}",r:1}
