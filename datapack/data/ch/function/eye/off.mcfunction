# Op: stop being the Eye.
execute unless score @s ch.eye matches 1.. run return run tellraw @s {text:"You are not the Eye.",color:"gray"}
scoreboard players operation #o ch.tmp = @s ch.pid
execute as @e[type=item_display,tag=ch.eyepart] if score @s ch.owner = #o ch.tmp run kill @s
scoreboard players set @s ch.eye 0
effect clear @s minecraft:invisibility
team leave @s
tag @a remove ch.gazed
execute store result storage ch:tmp ey.pid int 1 run scoreboard players get @s ch.pid
function ch:eye/restore with storage ch:tmp ey
playsound chaoshearts:eye_close master @a ~ ~ ~ 3 0.8
particle minecraft:squid_ink ~ ~2 ~ 1.5 1.5 1.5 0.3 200 force
tellraw @s {text:"The Eye closes. You are yourself again.",color:"dark_purple"}
