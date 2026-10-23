# A marked strike lands.
function ch:kit/storm/fn/bolt
execute unless entity @a[tag=ch.challenger,distance=..2.4,limit=1] run return 0
execute as @e[tag=ch.boss,distance=..90,limit=1] run function ch:trials/storm/b/caster
execute as @a[tag=ch.challenger,distance=..2.4] run function ch:trials/storm/b/hit {d:90}
execute as @a[tag=ch.challenger,distance=..2.4] run function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:1}
tag @e[tag=ch.boss,distance=..90] remove ch.caster
