# An untripped mine fades away harmlessly.
particle minecraft:reverse_portal ~ ~ ~ 0.2 0.2 0.2 0.1 15
playsound minecraft:block.portal.trigger player @a ~ ~ ~ 0.2 2
execute if score @s ch.v5 matches 1 run function ch:kit/void/sing/mini
kill @s
