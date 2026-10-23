# Golgoth's decorations follow it: the boulders orbit, the crown turns, the core glows at its chest.
execute as @e[type=block_display,tag=ch.titan.borb,distance=..40] rotated as @s rotated ~7 0 positioned ~ ~3.4 ~ run tp @s ~ ~ ~ ~ 0
execute as @e[type=block_display,tag=ch.titan.bcrown,distance=..40] rotated as @s rotated ~2 0 positioned ~ ~5.2 ~ run tp @s ~ ~ ~ ~ 0
execute as @e[type=item_display,tag=ch.titan.bcore,distance=..40] rotated ~ 0 positioned ~ ~3 ~ run tp @s ~ ~ ~ ~ 0
execute if score @s ch.phase matches 3.. as @e[type=block_display,tag=ch.titan.borb,distance=..40] at @s run tp @s ~ ~0.8 ~
execute if score @s ch.phase matches 3.. as @e[type=block_display,tag=ch.titan.bcrown,distance=..40] at @s run tp @s ~ ~0.8 ~
execute if score @s ch.phase matches 3.. as @e[type=item_display,tag=ch.titan.bcore,distance=..40] at @s run tp @s ~ ~0.4 ~
