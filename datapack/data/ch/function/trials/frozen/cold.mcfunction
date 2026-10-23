# As the challenger in the blizzard: Cold rises while still, falls while moving; at 60 they freeze solid.
particle minecraft:snowflake ~ ~2 ~ 6 2 6 0.1 20
particle minecraft:white_ash ~ ~2 ~ 6 2 6 0 6
execute store result score #fx1 ch.tmp run data get entity @s Pos[0] 10
execute store result score #fz1 ch.tmp run data get entity @s Pos[2] 10
scoreboard players operation #fdx ch.tmp = #fx1 ch.tmp
scoreboard players operation #fdx ch.tmp -= @s ch.frozen.tx
scoreboard players operation #fdz ch.tmp = #fz1 ch.tmp
scoreboard players operation #fdz ch.tmp -= @s ch.frozen.tz
scoreboard players operation #fdx ch.tmp *= #fdx ch.tmp
scoreboard players operation #fdz ch.tmp *= #fdz ch.tmp
scoreboard players operation #fdx ch.tmp += #fdz ch.tmp
scoreboard players operation @s ch.frozen.tx = #fx1 ch.tmp
scoreboard players operation @s ch.frozen.tz = #fz1 ch.tmp
execute if score #fdx ch.tmp matches ..2 run scoreboard players add @s ch.frozen.tc 3
execute if score #fdx ch.tmp matches 3.. run scoreboard players remove @s ch.frozen.tc 2
execute if score @s ch.frozen.tc matches ..-1 run scoreboard players set @s ch.frozen.tc 0
execute if score @s ch.frozen.tc matches 30.. if score #t20 ch.g matches 0 run function ch:api/fx/screen {o:"frozen",color:"#F2FBFF",in:4,stay:12,out:10}
execute if score @s ch.frozen.tc matches 30.. run particle minecraft:snowflake ~ ~1 ~ 0.3 0.6 0.3 0.01 3
execute if score @s ch.frozen.tc matches 60.. run function ch:trials/frozen/cold_freeze
