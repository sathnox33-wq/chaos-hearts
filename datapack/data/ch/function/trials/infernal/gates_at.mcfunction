# Opens the three gates at random spots 6..20 blocks from the centre.
summon minecraft:marker ~ ~ ~ {Tags:["ch.tmob","ch.noability","ch.infernal.gr"]}
execute as @e[type=marker,tag=ch.infernal.gr,limit=1] store result entity @s Rotation[0] float 1 run random value 0..359
execute rotated as @e[type=marker,tag=ch.infernal.gr,limit=1] rotated ~ 0 positioned ^ ^ ^9 positioned ~ 100 ~ run function ch:trials/infernal/gate_new
execute rotated as @e[type=marker,tag=ch.infernal.gr,limit=1] rotated ~120 0 positioned ^ ^ ^16 positioned ~ 100 ~ run function ch:trials/infernal/gate_new
execute rotated as @e[type=marker,tag=ch.infernal.gr,limit=1] rotated ~240 0 positioned ^ ^ ^12 positioned ~ 100 ~ run function ch:trials/infernal/gate_new
kill @e[type=marker,tag=ch.infernal.gr]
