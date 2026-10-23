# Phase 3: the floor cracks into nothing - one crack under the challenger, two elsewhere; they linger and hurt.
execute as @a[tag=ch.challenger,limit=1] run function ch:core/msg/say {m:"The floor cracks into nothing!",c:"#D38CFF"}
execute at @a[tag=ch.challenger,limit=1] positioned ~ ~0.1 ~ run function ch:trials/void/crack_mark
execute at @e[type=marker,tag=ch.session,limit=1,sort=nearest] rotated ~ 0 positioned ^9 ^1.1 ^9 run function ch:trials/void/crack_mark
execute at @e[type=marker,tag=ch.session,limit=1,sort=nearest] rotated ~ 0 positioned ^-11 ^1.1 ^-6 run function ch:trials/void/crack_mark
