# Great Wall: the outer columns.
scoreboard players set #f_cd ch.tmp 3
execute rotated ~ 0 positioned ^-3 ^ ^2.5 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 3
execute rotated ~ 0 positioned ^3 ^ ^2.5 run function ch:kit/frozen/wall/col_at
