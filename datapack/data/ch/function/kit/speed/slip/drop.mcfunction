# Drops one wake marker under the runner (it lives two seconds).
summon minecraft:marker ~ ~0.1 ~ {Tags:["ch.speed.wake","ch.noability","ch.speed.wnew"]}
scoreboard players operation @e[type=marker,tag=ch.speed.wnew,limit=1] ch.owner = @s ch.pid
scoreboard players set @e[type=marker,tag=ch.speed.wnew,limit=1] ch.life 40
scoreboard players operation @e[type=marker,tag=ch.speed.wnew,limit=1] ch.v1 = @s ch.speed.smode
scoreboard players set @e[type=marker,tag=ch.speed.wnew,limit=1] ch.v2 0
execute if score @s ch.b3 matches 1.. run scoreboard players set @e[type=marker,tag=ch.speed.wnew,limit=1] ch.v2 1
tag @e[type=marker,tag=ch.speed.wnew] remove ch.speed.wnew
particle minecraft:cloud ~ ~0.1 ~ 0.1 0.02 0.1 0.01 1
execute if score @s ch.speed.smode matches 1 run particle minecraft:flame ~ ~0.2 ~ 0.15 0.05 0.15 0.01 3
