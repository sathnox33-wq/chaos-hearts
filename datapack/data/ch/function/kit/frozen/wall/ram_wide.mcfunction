# Great Wall: the outer ram columns.
scoreboard players set #f_h ch.tmp 1
execute rotated ~ 0 positioned ^-3 ^0 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 0
execute rotated ~ 0 positioned ^-3 ^1 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 1
execute rotated ~ 0 positioned ^3 ^0 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 0
execute rotated ~ 0 positioned ^3 ^1 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
