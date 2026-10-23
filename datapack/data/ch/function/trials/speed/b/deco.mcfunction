# Keeps the halo, crown star and back rune on Vael; the star spins.
execute rotated as @s rotated ~ 0 run tp @e[type=item_display,tag=ch.speed.halo,distance=..40,limit=1] ~ ~3.1 ~ ~ 0
tp @e[type=item_display,tag=ch.speed.star,distance=..40,limit=1] ~ ~3.5 ~
execute as @e[type=item_display,tag=ch.speed.star,distance=..40,limit=1] at @s run tp @s ~ ~ ~ ~14 0
execute rotated as @s rotated ~ 0 positioned ^ ^1.9 ^-0.8 run tp @e[type=item_display,tag=ch.speed.rune,distance=..40,limit=1] ~ ~ ~ ~180 90
