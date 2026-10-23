# Tick... tock...: a huge clock face under you winds down for 28 ticks, then the bell strikes.
execute if score @s ch.v2 matches 1 as @a[tag=ch.challenger,limit=1] at @s positioned ~ 100 ~ run function ch:trials/speed/b/tock_mark
execute if score @s ch.v2 matches 8 at @e[type=marker,tag=ch.speed.tock,distance=..80,limit=1] run playsound minecraft:block.note_block.hat master @a[distance=..40] ~ ~ ~ 1.2 1.0
execute if score @s ch.v2 matches 16 at @e[type=marker,tag=ch.speed.tock,distance=..80,limit=1] run playsound minecraft:block.note_block.hat master @a[distance=..40] ~ ~ ~ 1.2 1.3
execute if score @s ch.v2 matches 24 at @e[type=marker,tag=ch.speed.tock,distance=..80,limit=1] run playsound minecraft:block.note_block.hat master @a[distance=..40] ~ ~ ~ 1.2 1.7
execute if score @s ch.v2 matches 29 at @e[type=marker,tag=ch.speed.tock,distance=..80,limit=1] run function ch:trials/speed/b/tock_blast
execute if score @s ch.v2 matches 40.. run function ch:trials/speed/b/end
