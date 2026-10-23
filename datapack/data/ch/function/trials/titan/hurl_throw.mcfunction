# The boulder leaves Golgoth's hands: the spot under the challenger is marked and the rock comes down there.
execute positioned as @e[tag=ch.titan.boss,distance=..80,limit=1] run kill @e[type=block_display,tag=ch.titan.brock,distance=..20]
execute positioned as @e[tag=ch.titan.boss,distance=..80,limit=1] run playsound minecraft:entity.iron_golem.attack master @a ~ ~ ~ 2 0.6
execute at @a[tag=ch.challenger,limit=1] run function ch:trials/titan/rock_mark {r:3.2,d:6.4}
