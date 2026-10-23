# Every tick of the Titan trial: grit and ash drift down around the challenger; the quarry rumbles.
execute at @a[tag=ch.challenger,limit=1] run particle minecraft:white_ash ~ ~4 ~ 9 3 9 0 12
execute at @a[tag=ch.challenger,limit=1] run particle minecraft:falling_dust{block_state:"minecraft:gravel"} ~ ~9 ~ 9 1 9 0 3
execute if score #t20 ch.g matches 0 at @a[tag=ch.challenger,limit=1] run particle minecraft:campfire_cosy_smoke ~ ~-0.5 ~ 12 0 12 0.005 3
execute if score #t20 ch.g matches 7 if entity @e[tag=ch.titan.boss,distance=..80,scores={ch.phase=2..},limit=1] at @a[tag=ch.challenger,limit=1] run particle minecraft:lava ~ ~0.2 ~ 10 0 10 0 3
