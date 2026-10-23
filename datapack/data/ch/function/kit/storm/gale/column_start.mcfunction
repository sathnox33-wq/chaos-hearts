# Updraft Column: marks the aimed ground, and a geyser of wind erupts there 10 ticks later.
function ch:api/ray {range:16}
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.gm","ch.noability"]}
scoreboard players set #gn ch.storm.g 0
execute if entity @e[tag=ch.target,limit=1] at @e[tag=ch.target,limit=1] run tp @e[type=marker,tag=ch.storm.gm,limit=1] ~ ~ ~
execute unless entity @e[tag=ch.target,limit=1] at @e[type=marker,tag=ch.rayend,limit=1] run function ch:kit/storm/fn/ground
scoreboard players set #v1 ch.storm.g 30
scoreboard players set #v2 ch.storm.g 0
scoreboard players set #v3 ch.storm.g 0
scoreboard players set #v4 ch.storm.g 0
execute if score @s ch.b2 matches 1.. run scoreboard players set #v2 ch.storm.g 1
execute at @e[type=marker,tag=ch.storm.gm,limit=1] run function ch:kit/storm/gale/column_mark
kill @e[type=marker,tag=ch.storm.gm]
playsound minecraft:entity.breeze.inhale player @a ~ ~ ~ 1 0.8
title @s subtitle {text:"Updraft Column",color:"#E8F6FF",italic:true}
return 1
