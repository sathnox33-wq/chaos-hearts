# Runs every VFX timeline marker. #vfx stays 1 while any exist; #vb is the per-tick budget for the extra layers that
# the shared FX calls add (see vfx/up), so a burst of calls in one tick cannot flood clients.
scoreboard players set #vfx ch.g 0
execute as @e[type=marker,tag=ch.vfx] at @s run function ch:vfx/tick
execute if entity @e[type=marker,tag=ch.vfx,limit=1] run scoreboard players set #vfx ch.g 1
