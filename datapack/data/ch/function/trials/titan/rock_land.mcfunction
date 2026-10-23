# A boulder crashes down: 9 damage to the challenger within 3.2 blocks.
function ch:kit/titan/rock/blast_fx {b:"minecraft:cobblestone"}
tag @e[tag=ch.titan.boss,distance=..80,limit=1] add ch.caster
execute positioned ~ ~0.5 ~ as @a[tag=ch.challenger,distance=..3.2] run function ch:trials/titan/hurt {d:90}
tag @e[tag=ch.titan.boss,distance=..80] remove ch.caster
