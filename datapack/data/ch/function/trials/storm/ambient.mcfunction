# The Eye of the Storm, every tick: rain, wind, distant lightning on the rim rods, and the static zones.
execute if score #t2 ch.storm.g matches 0 at @a[tag=ch.challenger,limit=1] run particle minecraft:falling_water ~ ~7 ~ 9 1 9 0 30
execute if score #t5 ch.storm.g matches 0 at @a[tag=ch.challenger,limit=1] run particle minecraft:cloud ~ ~12 ~ 12 1 12 0.02 6
execute if score #t20 ch.g matches 0 store result score #r ch.storm.g run random value 1..6
execute if score #t20 ch.g matches 0 if score #r ch.storm.g matches 1 run function ch:trials/storm/rod_bolt
execute if score #t20 ch.g matches 10 run playsound minecraft:weather.rain master @a[tag=ch.challenger] ~ ~ ~ 0.5 0.8
execute if entity @e[type=marker,tag=ch.storm.zone,distance=..80,limit=1] as @e[type=marker,tag=ch.storm.zone,distance=..80] at @s run function ch:trials/storm/zone_tick
