# Phase 2+: four pustules swell up across the garden; after 2 seconds they burst.
execute as @a[tag=ch.challenger,limit=1] run function ch:core/msg/say {m:"The pustules are swelling - get clear!",c:"#A4FF4F"}
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^ ^ ^4 run function ch:trials/corruption/pustule
execute at @e[type=marker,tag=ch.session,limit=1,sort=nearest] rotated ~ 0 positioned ^10 ^1 ^4 run function ch:trials/corruption/pustule
execute at @e[type=marker,tag=ch.session,limit=1,sort=nearest] rotated ~ 0 positioned ^-8 ^1 ^-9 run function ch:trials/corruption/pustule
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^-3 ^ ^-3 run function ch:trials/corruption/pustule
