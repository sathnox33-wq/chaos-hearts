# The crown and halo ride on Voltaris; three orbs circle it.
tp @e[type=item_display,tag=ch.storm.crown,distance=..40,limit=1] ~ ~3.7 ~
execute as @e[type=item_display,tag=ch.storm.crown,distance=..40,limit=1] at @s run tp @s ~ ~ ~ ~9 0
execute rotated as @s rotated ~ 0 run tp @e[type=item_display,tag=ch.storm.halo,distance=..40,limit=1] ~ ~3.4 ~ ~ 0
tp @e[type=marker,tag=ch.storm.piv,distance=..40,limit=1] ~ ~ ~
execute as @e[type=marker,tag=ch.storm.piv,distance=..40,limit=1] at @s run tp @s ~ ~ ~ ~12 0
execute at @e[type=marker,tag=ch.storm.piv,distance=..40,limit=1] rotated as @e[type=marker,tag=ch.storm.piv,distance=..40,limit=1] positioned ^ ^2.2 ^1.8 run tp @e[type=item_display,tag=ch.storm.o1,distance=..40,limit=1] ~ ~ ~
execute at @e[type=marker,tag=ch.storm.piv,distance=..40,limit=1] rotated as @e[type=marker,tag=ch.storm.piv,distance=..40,limit=1] rotated ~120 0 positioned ^ ^2.6 ^1.8 run tp @e[type=item_display,tag=ch.storm.o2,distance=..40,limit=1] ~ ~ ~
execute at @e[type=marker,tag=ch.storm.piv,distance=..40,limit=1] rotated as @e[type=marker,tag=ch.storm.piv,distance=..40,limit=1] rotated ~240 0 positioned ^ ^1.8 ^1.8 run tp @e[type=item_display,tag=ch.storm.o3,distance=..40,limit=1] ~ ~ ~
execute if score #t5 ch.storm.g matches 0 at @e[type=item_display,tag=ch.storm.orb,distance=..40] run particle minecraft:electric_spark ~ ~ ~ 0.1 0.1 0.1 0.05 2
