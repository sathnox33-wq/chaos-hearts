# The star lands: 7 damage to the challenger within 2.3 blocks.
function ch:kit/celestial/star/boom {r:2.3,d:3.0}
tag @e[tag=ch.celestial.boss,distance=..80,limit=1] add ch.caster
execute positioned ~ ~0.8 ~ as @a[tag=ch.challenger,distance=..2.3] run function ch:trials/celestial/hurt {d:70}
tag @e[tag=ch.celestial.boss,distance=..80] remove ch.caster
