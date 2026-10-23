# Frozen aura (mastery 90): a drifting halo of snow, frost crawling outward from your feet.
scoreboard players operation #f_m ch.tmp = #now ch.g
scoreboard players operation #f_m ch.tmp %= #4 ch.g
execute unless score #f_m ch.tmp matches 0 run return 0
particle minecraft:snowflake ~ ~1 ~ 0.4 0.6 0.4 0.01 2
particle minecraft:white_ash ~ ~1.5 ~ 0.6 0.6 0.6 0 2
execute if score @s ch.awake matches 1 run particle minecraft:dust{color:[0.61,0.91,1.0],scale:1.0} ~ ~0.1 ~ 0.4 0 0.4 0 2
execute if score #t20 ch.g matches 0 rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"hex",color:6273256,s0:0.8,s1:2.6,t:14,life:18,spin:90,dy:0.0}
