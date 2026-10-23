# Picks a meteor's spot near the challenger (the first right on them) and paints its circle.
execute store result entity @s Rotation[0] float 1 run random value 0..359
execute if score @s ch.v1 matches 0 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^0 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
execute if score @s ch.v1 matches 1 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^3 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
execute if score @s ch.v1 matches 2 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^5 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
execute if score @s ch.v1 matches 3 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^4 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
execute if score @s ch.v1 matches 4 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^6 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
execute if score @s ch.v1 matches 5 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^2.5 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
execute if score @s ch.v1 matches 6 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^7 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
execute if score @s ch.v1 matches 7 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^4.5 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
execute if score @s ch.v1 matches 8 at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] rotated as @s rotated ~ 0 positioned ^ ^ ^5.5 positioned ~ 100 ~ run function ch:trials/infernal/met_tele
