# Internal: points the last button back to the picked player's page.
scoreboard players operation #pc ch.tmp = @s ch.adt
scoreboard players add #pc ch.tmp 1000
execute store result storage ch:tmp ap.c int 1 run scoreboard players get #pc ch.tmp
function ch:admin/ui/back_target2 with storage ch:tmp ap
