# A wall 5 wide (7 with Great Wall), 3 high, 2.5 blocks ahead; it rises from the middle out. Enemies in the way are hurled back.
scoreboard players set #f_cd ch.tmp 2
execute rotated ~ 0 positioned ^-2 ^ ^2.5 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 1
execute rotated ~ 0 positioned ^-1 ^ ^2.5 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 0
execute rotated ~ 0 positioned ^0 ^ ^2.5 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 1
execute rotated ~ 0 positioned ^1 ^ ^2.5 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 2
execute rotated ~ 0 positioned ^2 ^ ^2.5 run function ch:kit/frozen/wall/col_at
execute if score @s ch.b1 matches 3.. run function ch:kit/frozen/wall/line_wide
execute rotated ~ 0 positioned ^ ^1 ^2.5 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.6] run function ch:kit/frozen/wall/shove
execute rotated ~ 0 positioned ^ ^1 ^2.5 run function ch:kit/frozen/wall/line_fx
return 1
