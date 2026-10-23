# Astrael's decorations follow it: the halo over its head, wings that beat, two stars in orbit, the shield dome.
scoreboard players operation #ce_flap ch.tmp = @s ch.t
scoreboard players operation #ce_flap ch.tmp /= #8 ch.celestial.k
scoreboard players operation #ce_flap ch.tmp %= #2 ch.g
execute as @e[type=item_display,tag=ch.celestial.bhalo,distance=..40] positioned ~ ~2.8 ~ run tp @s ~ ~ ~ 0 0
execute as @e[type=item_display,tag=ch.celestial.bstar,distance=..40] rotated as @s rotated ~9 0 positioned ^ ^1.2 ^2.2 run tp @s ~ ~ ~ ~ 0
execute as @e[type=item_display,tag=ch.celestial.bdome,distance=..40] positioned ~ ~1 ~ run tp @s ~ ~ ~ 0 0
execute as @e[type=item_display,tag=ch.celestial.bwing,scores={ch.v1=1},distance=..40] if score #ce_flap ch.tmp matches 0 rotated ~ 0 positioned ^0.6 ^1.6 ^-0.5 run tp @s ~ ~ ~ ~-100 -30
execute as @e[type=item_display,tag=ch.celestial.bwing,scores={ch.v1=1},distance=..40] if score #ce_flap ch.tmp matches 1 rotated ~ 0 positioned ^0.6 ^1.9 ^-0.5 run tp @s ~ ~ ~ ~-110 -50
execute as @e[type=item_display,tag=ch.celestial.bwing,scores={ch.v1=2},distance=..40] if score #ce_flap ch.tmp matches 0 rotated ~ 0 positioned ^1.4 ^1.9 ^-0.6 run tp @s ~ ~ ~ ~-92 -5
execute as @e[type=item_display,tag=ch.celestial.bwing,scores={ch.v1=2},distance=..40] if score #ce_flap ch.tmp matches 1 rotated ~ 0 positioned ^1.4 ^2.2 ^-0.6 run tp @s ~ ~ ~ ~-102 -25
execute as @e[type=item_display,tag=ch.celestial.bwing,scores={ch.v1=3},distance=..40] if score #ce_flap ch.tmp matches 0 rotated ~ 0 positioned ^-0.6 ^1.6 ^-0.5 run tp @s ~ ~ ~ ~100 -30
execute as @e[type=item_display,tag=ch.celestial.bwing,scores={ch.v1=3},distance=..40] if score #ce_flap ch.tmp matches 1 rotated ~ 0 positioned ^-0.6 ^1.9 ^-0.5 run tp @s ~ ~ ~ ~110 -50
execute as @e[type=item_display,tag=ch.celestial.bwing,scores={ch.v1=4},distance=..40] if score #ce_flap ch.tmp matches 0 rotated ~ 0 positioned ^-1.4 ^1.9 ^-0.6 run tp @s ~ ~ ~ ~92 -5
execute as @e[type=item_display,tag=ch.celestial.bwing,scores={ch.v1=4},distance=..40] if score #ce_flap ch.tmp matches 1 rotated ~ 0 positioned ^-1.4 ^2.2 ^-0.6 run tp @s ~ ~ ~ ~102 -25
