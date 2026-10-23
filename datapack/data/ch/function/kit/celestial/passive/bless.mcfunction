# An ally receives Radiance.
execute unless entity @a[tag=ch.caster,scores={ch.b2=4..},limit=1] run function ch:api/heal {n:2}
execute if entity @a[tag=ch.caster,scores={ch.b2=4..},limit=1] run function ch:api/heal {n:4}
particle minecraft:happy_villager ~ ~1.8 ~ 0.3 0.2 0.3 0 3
particle minecraft:end_rod ~ ~1 ~ 0.3 0.6 0.3 0.02 4
