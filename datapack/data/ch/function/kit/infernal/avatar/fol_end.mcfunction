# A follower bursts into embers.
execute at @s run particle minecraft:flame ~ ~ ~ 0.2 0.2 0.2 0.05 6
execute at @s run particle minecraft:large_smoke ~ ~ ~ 0.1 0.1 0.1 0.02 2
tag @a remove ch.caster
kill @s
