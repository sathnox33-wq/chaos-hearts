# Void Lances (phase 2+): five runes around the challenger; 25 ticks later beams of nothing strike them.
execute as @a[tag=ch.challenger,limit=1] run function ch:core/msg/say {m:"Lances fall from the dark! Leave the runes!",c:"#D38CFF"}
playsound chaoshearts:trial_telegraph hostile @a ~ ~ ~ 1.2 1.3
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ~ ~0.1 ~ run function ch:trials/void/lance_mark
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^3.5 ^0.1 ^2 run function ch:trials/void/lance_mark
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^-3.5 ^0.1 ^2 run function ch:trials/void/lance_mark
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^2.5 ^0.1 ^-3 run function ch:trials/void/lance_mark
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^-2.5 ^0.1 ^-3 run function ch:trials/void/lance_mark
