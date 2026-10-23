# Ground snap: one block up.
scoreboard players remove #f_sn ch.tmp 1
tp @s ~ ~1 ~
execute at @s run function ch:kit/frozen/gs
