# Storm, every tick: ground currents, charged ground, cyclones, the eye, tethers, ionized marks and wall timers.
scoreboard players operation #t2 ch.storm.g = #now ch.g
scoreboard players operation #t2 ch.storm.g %= #2 ch.g
scoreboard players operation #t3 ch.storm.g = #now ch.g
scoreboard players operation #t3 ch.storm.g %= #c3 ch.storm.g
scoreboard players operation #t5 ch.storm.g = #now ch.g
scoreboard players operation #t5 ch.storm.g %= #5 ch.g
scoreboard players operation #t10 ch.storm.g = #now ch.g
scoreboard players operation #t10 ch.storm.g %= #10 ch.g
execute if entity @e[type=marker,tag=ch.storm.cur,limit=1] as @e[type=marker,tag=ch.storm.cur] at @s run function ch:kit/storm/ls/current
execute if entity @e[type=marker,tag=ch.storm.cg,limit=1] as @e[type=marker,tag=ch.storm.cg] at @s run function ch:kit/storm/ls/charged
execute if entity @e[type=marker,tag=ch.storm.cyc,limit=1] as @e[type=marker,tag=ch.storm.cyc] at @s run function ch:kit/storm/gale/cyclone
execute if entity @e[type=marker,tag=ch.storm.eye,limit=1] as @e[type=marker,tag=ch.storm.eye] at @s run function ch:kit/storm/tempest/eye
execute if score #teth ch.storm.g matches 1 run function ch:kit/storm/chain/tethers
execute if score #ion ch.storm.g matches 1 run function ch:kit/storm/fn/ion_tick
