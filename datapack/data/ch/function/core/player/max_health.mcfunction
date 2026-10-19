# Each Chaos Heart held is one more heart (2 HP) of max health, up to 10 extra hearts.
function ch:gen/count
execute if score #owned ch.tmp matches 11.. run scoreboard players set #owned ch.tmp 10
scoreboard players operation #owned ch.tmp *= #2 ch.g
execute store result storage ch:tmp n.hp int 1 run scoreboard players get #owned ch.tmp
attribute @s minecraft:max_health modifier remove ch:hearts
execute if score #owned ch.tmp matches 1.. run function ch:core/player/max_health2 with storage ch:tmp n
