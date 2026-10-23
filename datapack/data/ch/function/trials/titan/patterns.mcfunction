# Picks Golgoth's next attack: Earthshatter, Boulder Hurl, the Stomp punish, Stone Skin (phase 2) and the avalanche (phase 3).
scoreboard players remove @s ch.v1 1
scoreboard players remove @s ch.v2 1
execute if score @s ch.v1 matches ..0 run return run function ch:trials/titan/shatter
execute if score @s ch.v2 matches ..0 run return run function ch:trials/titan/hurl
execute if entity @a[tag=ch.challenger,distance=..5.5] run scoreboard players add @s ch.v3 1
execute unless entity @a[tag=ch.challenger,distance=..5.5] if score @s ch.v3 matches 1.. run scoreboard players remove @s ch.v3 1
execute if score @s ch.v3 matches 35.. run return run function ch:trials/titan/stomp
execute if score @s ch.phase matches 2.. run scoreboard players remove @s ch.v5 1
execute if score @s ch.phase matches 2.. if score @s ch.v5 matches ..0 run function ch:trials/titan/skin
execute if score @s ch.phase matches 3.. run scoreboard players remove @s ch.titan.tb1 1
execute if score @s ch.phase matches 3.. if score @s ch.titan.tb1 matches ..0 run function ch:trials/titan/avalanche
