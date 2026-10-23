# Ground snap: one block down.
scoreboard players remove #i_sn ch.tmp 1
tp @s ~ ~-1 ~
execute at @s run function ch:kit/infernal/gs
