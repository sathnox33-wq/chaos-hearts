# The Rotting Garden, every tick of the fight: spores and mycelium drift around the challenger, puddles fester,
# and in phase 3 the infestation grows from the centre.
execute at @a[tag=ch.challenger,limit=1] run particle minecraft:spore_blossom_air ~ ~4 ~ 9 2 9 0 3
execute at @a[tag=ch.challenger,limit=1] run particle minecraft:mycelium ~ ~0.5 ~ 8 0.5 8 0 6
execute if score #t20 ch.g matches 0 at @a[tag=ch.challenger,limit=1] run particle minecraft:falling_spore_blossom ~ ~6 ~ 8 1 8 0 6
execute if entity @e[type=marker,tag=ch.corruption.tpud,distance=..60,limit=1] as @e[type=marker,tag=ch.corruption.tpud,distance=..60] at @s run function ch:trials/corruption/tpud_tick
execute if entity @e[tag=ch.boss,scores={ch.corruption.bp=3..},distance=..80,limit=1] run function ch:trials/corruption/rotgrow
