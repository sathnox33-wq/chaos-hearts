# A mob shivers: freeze ticks build up.
execute store result score #f_x ch.tmp run data get entity @s TicksFrozen
scoreboard players add #f_x ch.tmp 30
execute if score #f_x ch.tmp matches 139.. run scoreboard players set #f_x ch.tmp 139
execute store result entity @s TicksFrozen int 1 run scoreboard players get #f_x ch.tmp
