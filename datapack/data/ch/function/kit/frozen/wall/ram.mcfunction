# Glacier Ram: a wall of ice 5 wide (7) rises before you and charges 10 blocks forward, bulldozing everything.
scoreboard players set #f_h ch.tmp 1
execute rotated ~ 0 positioned ^-2 ^0 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 0
execute rotated ~ 0 positioned ^-2 ^1 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 1
execute rotated ~ 0 positioned ^-1 ^0 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 0
execute rotated ~ 0 positioned ^-1 ^1 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 1
execute rotated ~ 0 positioned ^0 ^0 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 0
execute rotated ~ 0 positioned ^0 ^1 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 1
execute rotated ~ 0 positioned ^1 ^0 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 0
execute rotated ~ 0 positioned ^1 ^1 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 1
execute rotated ~ 0 positioned ^2 ^0 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
scoreboard players set #f_h ch.tmp 0
execute rotated ~ 0 positioned ^2 ^1 ^1.5 summon minecraft:block_display run function ch:kit/frozen/wall/ram_init
execute if score @s ch.b1 matches 3.. run function ch:kit/frozen/wall/ram_wide
execute rotated ~ 0 positioned ^ ^1 ^1.5 run function ch:kit/frozen/wall/line_fx
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 0.6 1.6
return 1
