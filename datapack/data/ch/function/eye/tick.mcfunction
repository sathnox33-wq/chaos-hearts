# Every tick for each Eye: its parts follow the player, the pupil turns toward whoever it is watching,
# and darkness bleeds out around it.
execute as @a[scores={ch.eye=1..}] at @s run function ch:eye/follow
