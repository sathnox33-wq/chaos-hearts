# Cyclone (capstone): a vortex at the caster's feet seizes everything within 7 blocks.
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.cyc","ch.noability","ch.storm.cynew"]}
scoreboard players operation @e[type=marker,tag=ch.storm.cynew,limit=1] ch.owner = @s ch.pid
scoreboard players set @e[type=marker,tag=ch.storm.cynew,limit=1] ch.life 40
tag @e[type=marker,tag=ch.storm.cynew] remove ch.storm.cynew
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..7] run scoreboard players add #pushed ch.storm.g 1
