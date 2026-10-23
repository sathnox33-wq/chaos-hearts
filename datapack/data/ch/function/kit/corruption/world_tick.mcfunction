# Corruption world tick: plague clouds, rot fields, infections, rotlings, plague storms, rot tracking.
execute if entity @e[type=marker,tag=ch.corruption.cloud,limit=1] as @e[type=marker,tag=ch.corruption.cloud] at @s run function ch:kit/corruption/cloud/tick
execute if entity @e[type=marker,tag=ch.corruption.rot,limit=1] as @e[type=marker,tag=ch.corruption.rot] at @s run function ch:kit/corruption/rot/tick
execute if entity @e[type=marker,tag=ch.corruption.inf,limit=1] as @e[type=marker,tag=ch.corruption.inf] at @s run function ch:kit/corruption/inf/tick
execute if entity @e[type=husk,tag=ch.corruption.ling,limit=1] as @e[type=husk,tag=ch.corruption.ling] at @s run function ch:kit/corruption/ling/tick
execute if entity @e[type=marker,tag=ch.corruption.storm,limit=1] as @e[type=marker,tag=ch.corruption.storm] at @s run function ch:kit/corruption/pan/storm_tick
execute if entity @e[tag=ch.corruption.inrot,limit=1] as @e[tag=ch.corruption.inrot] run function ch:kit/corruption/rot/mark_tick
