# The prison slams shut on whoever is still inside.
particle minecraft:block{block_state:"minecraft:packed_ice"} ~ ~1 ~ 1 1 1 0.2 40
playsound minecraft:block.glass.place master @a[distance=..40] ~ ~ ~ 2 0.6
execute positioned ~ ~0.5 ~ as @a[tag=ch.challenger,distance=..1.7] at @s run function ch:trials/frozen/prison_hit
