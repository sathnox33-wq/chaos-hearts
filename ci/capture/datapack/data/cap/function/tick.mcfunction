# Camera rigs for the capture run. #mode cap: 0 off, 1 follow the caster from the side, 2 orbit the pivot marker.
execute if score #mode cap matches 1 as Cam at Caster positioned ~ ~ ~3 run tp @s ~9 ~5 ~-5 facing ~ ~1 ~
execute if score #mode cap matches 2 as @e[type=marker,tag=cap.pivot,limit=1] at @s run tp @s ~ ~ ~ ~1.2 0
execute if score #mode cap matches 2 at @e[type=marker,tag=cap.pivot,limit=1] rotated as @e[type=marker,tag=cap.pivot,limit=1] positioned ^ ^ ^-11 run tp Cam ~ ~4 ~ facing entity @e[type=marker,tag=cap.pivot,limit=1] feet
