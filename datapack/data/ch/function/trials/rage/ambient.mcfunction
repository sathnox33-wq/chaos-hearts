# The Crucible's air (as the session, every tick): ash and embers around the challenger, and every 8 s a lava geyser
# erupts under them after a warning.
scoreboard players operation #m ch.tmp = #now ch.g
scoreboard players operation #m ch.tmp %= #4 ch.g
execute if score #m ch.tmp matches 0 at @a[tag=ch.challenger,distance=..60,limit=1] run particle minecraft:ash ~ ~3 ~ 8 3 8 0 30
execute if score #m ch.tmp matches 2 at @a[tag=ch.challenger,distance=..60,limit=1] run particle minecraft:crimson_spore ~ ~2 ~ 6 2 6 0 10
execute if score #m ch.tmp matches 1 run particle minecraft:lava ~ ~ ~ 26 0.5 26 0 3
scoreboard players operation #m ch.tmp = #now ch.g
scoreboard players operation #m ch.tmp %= #160 ch.rage.g
execute if score #m ch.tmp matches 0 at @a[tag=ch.challenger,distance=..60,limit=1] run function ch:trials/rage/geyser_mark
execute if entity @e[type=marker,tag=ch.rage.gey,distance=..60,limit=1] as @e[type=marker,tag=ch.rage.gey,distance=..60] at @s run function ch:trials/rage/geyser_tick
