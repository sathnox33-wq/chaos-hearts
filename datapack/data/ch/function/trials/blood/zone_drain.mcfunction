# The rain drinks from the challenger.
tag @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] add ch.caster
execute as @a[tag=ch.challenger,distance=..4] run function ch:api/hit {d:20}
tag @e[tag=ch.caster] remove ch.caster
execute as @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] run function ch:api/heal {n:4}
execute as @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] at @s run particle minecraft:heart ~ ~3 ~ 0.4 0.2 0.4 0 2
playsound minecraft:item.honey_bottle.drink master @a[distance=..90] ~ ~ ~ 1 0.5
