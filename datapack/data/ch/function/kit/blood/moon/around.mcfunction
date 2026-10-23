# The moon over its caster: falling blood, a turning ring of dust on the ground, and the bleed pulse.
execute if score #r4 ch.tmp matches 0 run particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~8 ~ 5 0.5 5 0 14
execute if score #r4 ch.tmp matches 2 run particle minecraft:crimson_spore ~ ~2 ~ 5 1.5 5 0 10
execute if score #r4 ch.tmp matches 0 positioned ~ ~0.1 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[0.62,0.04,0.12],scale:1.2}",r:10}
execute if score #t20 ch.g matches 0 run function ch:kit/blood/moon/pulse10
