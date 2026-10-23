# Incinerates projectiles crossing the segment (not its owner's).
scoreboard players operation #i_wo ch.tmp = @s ch.owner
execute as @e[type=#minecraft:impact_projectiles,distance=..2.3] at @s run function ch:kit/infernal/wall/burnproj
execute as @e[type=item_display,tag=ch.proj,distance=..2] at @s unless score @s ch.owner = #i_wo ch.tmp run function ch:kit/infernal/wall/burnproj2
