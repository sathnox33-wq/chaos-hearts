# The Racing Hour, every tick: drifting gold motes, the ticking of the clock, and the clock fields.
execute if score #t5 ch.speed.g matches 0 at @a[tag=ch.challenger,limit=1] run particle minecraft:end_rod ~ ~2 ~ 7 3 7 0.01 4
execute if score #t5 ch.speed.g matches 0 at @a[tag=ch.challenger,limit=1] run particle minecraft:dust{color:[0.96,0.88,0.26],scale:0.7} ~ ~2 ~ 8 3 8 0 10
execute if score #t20 ch.g matches 0 run playsound minecraft:block.note_block.hat master @a[tag=ch.challenger] ~ ~ ~ 0.25 0.7
execute if score #t20 ch.g matches 10 run playsound minecraft:block.note_block.hat master @a[tag=ch.challenger] ~ ~ ~ 0.25 0.5
execute if entity @e[type=marker,tag=ch.speed.zone,distance=..80,limit=1] as @e[type=marker,tag=ch.speed.zone,distance=..80] at @s run function ch:trials/speed/zone_tick
