# An Eye who logged out comes back as the Eye.
execute unless score @s ch.eye matches 1.. run return 0
scoreboard players operation #o ch.tmp = @s ch.pid
execute as @e[type=item_display,tag=ch.eyepart] if score @s ch.owner = #o ch.tmp run kill @s
function ch:eye/summon
