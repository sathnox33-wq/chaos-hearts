# Vael appears at the mark and cuts.
effect clear @s minecraft:invisibility
execute if entity @e[type=marker,tag=ch.speed.bspot,distance=..80,limit=1] run tp @s @e[type=marker,tag=ch.speed.bspot,distance=..80,limit=1]
execute at @s facing entity @a[tag=ch.challenger,limit=1] feet run tp @s ~ ~ ~ ~ 0
kill @e[type=marker,tag=ch.speed.bspot,distance=..80]
execute at @s run function ch:trials/speed/b/blink_hit
