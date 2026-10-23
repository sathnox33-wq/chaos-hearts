# As an enemy on the Updraft Column: thrown high (the fall is the danger).
function ch:kit/storm/fn/zap
execute if entity @s[type=!player] run data merge entity @s {Motion:[0.0,1.7,0.0]}
execute if entity @s[type=!player] if score #up ch.storm.g matches 1 run data merge entity @s {Motion:[0.0,2.1,0.0]}
execute if entity @s[type=player] positioned ~ ~-0.3 ~ summon minecraft:wind_charge run data merge entity @s {Motion:[0.0,-1.0,0.0]}
execute if entity @s[type=player] run function ch:api/cc {effect:"minecraft:levitation",sec:1,amp:12}
