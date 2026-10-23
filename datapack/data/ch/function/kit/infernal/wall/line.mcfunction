# A wall 7 blocks wide (10 with Wider Wall) 3 blocks ahead, across your look.
execute rotated ~ 0 positioned ^-3 ^ ^3 summon minecraft:marker run function ch:kit/infernal/wall/post_init
execute rotated ~ 0 positioned ^-2 ^ ^3 summon minecraft:marker run function ch:kit/infernal/wall/post_init
execute rotated ~ 0 positioned ^-1 ^ ^3 summon minecraft:marker run function ch:kit/infernal/wall/post_init
execute rotated ~ 0 positioned ^0 ^ ^3 summon minecraft:marker run function ch:kit/infernal/wall/post_init
execute rotated ~ 0 positioned ^1 ^ ^3 summon minecraft:marker run function ch:kit/infernal/wall/post_init
execute rotated ~ 0 positioned ^2 ^ ^3 summon minecraft:marker run function ch:kit/infernal/wall/post_init
execute rotated ~ 0 positioned ^3 ^ ^3 summon minecraft:marker run function ch:kit/infernal/wall/post_init
execute if score @s ch.b2 matches 1.. run function ch:kit/infernal/wall/line_wide
return 1
