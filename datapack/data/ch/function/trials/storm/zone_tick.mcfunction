# A static zone: sparks, and a shock every second for whoever stands in it.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
execute if score #t3 ch.storm.g matches 0 run particle minecraft:electric_spark ~ ~0.3 ~ 1.8 0.1 1.8 0.1 6
execute if score #t10 ch.storm.g matches 0 run function ch:api/fx/ring {p:"minecraft:dust{color:[0.31,0.66,1.0],scale:0.7}",r:3.5}
execute unless score #t20 ch.g matches 0 run return 0
execute unless entity @a[tag=ch.challenger,distance=..3.5,limit=1] run return 0
execute as @e[tag=ch.boss,distance=..90,limit=1] run function ch:trials/storm/b/caster
execute as @a[tag=ch.challenger,distance=..3.5] at @s run function ch:trials/storm/b/hit {d:20}
execute as @a[tag=ch.challenger,distance=..3.5] at @s run particle minecraft:electric_spark ~ ~1 ~ 0.3 0.6 0.3 0.3 15
tag @e[tag=ch.boss,distance=..90] remove ch.caster
