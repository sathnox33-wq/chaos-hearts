# Aura (mastery 90): the ground cracks under every step, gold dust drifts off the Titan; awakened, a crown of light.
execute if predicate ch:on_ground if predicate ch:input/forward run particle minecraft:block{block_state:"minecraft:cobblestone"} ~ ~0.1 ~ 0.3 0 0.3 0 3
execute if predicate ch:on_ground if predicate ch:input/forward run particle minecraft:dust{color:[0.478,0.455,0.416],scale:1.6} ~ ~0.1 ~ 0.4 0 0.4 0 2
particle minecraft:dust{color:[0.788,0.643,0.361],scale:0.8} ~ ~1.1 ~ 0.45 0.6 0.45 0 1
execute if score @s ch.awake matches 1 anchored eyes run particle minecraft:dust{color:[1.0,0.85,0.4],scale:0.7} ^ ^0.55 ^ 0.22 0.02 0.22 0 3
execute if score @s ch.awake matches 1 if score #t20 ch.g matches 0 anchored eyes run particle minecraft:end_rod ^ ^0.6 ^ 0.2 0.02 0.2 0 2
