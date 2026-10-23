# Spreads fan shot #i_k of #i_n sideways.
execute if score #i_n ch.tmp matches 3 if score #i_k ch.tmp matches 0 run tp @s ~ ~ ~ ~-8 ~
execute if score #i_n ch.tmp matches 3 if score #i_k ch.tmp matches 2 run tp @s ~ ~ ~ ~8 ~
execute if score #i_n ch.tmp matches 5 if score #i_k ch.tmp matches 0 run tp @s ~ ~ ~ ~-14 ~
execute if score #i_n ch.tmp matches 5 if score #i_k ch.tmp matches 1 run tp @s ~ ~ ~ ~-7 ~
execute if score #i_n ch.tmp matches 5 if score #i_k ch.tmp matches 3 run tp @s ~ ~ ~ ~7 ~
execute if score #i_n ch.tmp matches 5 if score #i_k ch.tmp matches 4 run tp @s ~ ~ ~ ~14 ~
