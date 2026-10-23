# An afterimage mine detonates.
particle minecraft:electric_spark ~ ~0.6 ~ 0.3 0.3 0.3 0.2 6
particle minecraft:firework ~ ~0.6 ~ 0.1 0.1 0.1 0.1 2
playsound minecraft:entity.firework_rocket.blast master @a[distance=..30] ~ ~ ~ 0.5 1.5
execute unless entity @a[tag=ch.challenger,distance=..1.6,limit=1] run return 0
execute as @e[tag=ch.boss,distance=..90,limit=1] run function ch:trials/speed/b/caster
execute as @a[tag=ch.challenger,distance=..1.6] run function ch:trials/speed/b/hit {d:60}
tag @e[tag=ch.boss,distance=..90] remove ch.caster
