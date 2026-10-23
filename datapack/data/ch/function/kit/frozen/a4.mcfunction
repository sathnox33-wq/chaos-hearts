# Absolute Zero. Level: call a blizzard here (10 blocks). Up: Eye of the Storm, a tighter blizzard that travels with you. Down: Shatterpoint, freeze everything within 12 blocks solid, then shatter them all at once.
scoreboard players operation #f_var ch.tmp = #var ch.tmp
execute if score #f_var ch.tmp matches 2 run return run function ch:kit/frozen/zero/sp_start
scoreboard players set #f_dur ch.tmp 160
execute if score @s ch.b3 matches 3.. run scoreboard players set #f_dur ch.tmp 208
summon minecraft:marker ~ ~ ~ {Tags:["ch.frozen.storm","ch.noability","ch.frozen.inew"]}
scoreboard players operation @e[type=marker,tag=ch.frozen.inew,limit=1] ch.owner = @s ch.pid
scoreboard players operation @e[type=marker,tag=ch.frozen.inew,limit=1] ch.life = #f_dur ch.tmp
scoreboard players set @e[type=marker,tag=ch.frozen.inew,limit=1] ch.v1 0
execute if score @s ch.b3 matches 4.. run scoreboard players set @e[type=marker,tag=ch.frozen.inew,limit=1] ch.v1 1
execute if score #f_var ch.tmp matches 1 run scoreboard players add @e[type=marker,tag=ch.frozen.inew,limit=1] ch.v1 2
scoreboard players set @e[type=marker,tag=ch.frozen.inew,limit=1] ch.v2 0
execute if score #f_var ch.tmp matches 1 run scoreboard players set @e[type=marker,tag=ch.frozen.inew,limit=1] ch.v2 1
scoreboard players set @e[type=marker,tag=ch.frozen.inew,limit=1] ch.v3 0
tag @e[type=marker,tag=ch.frozen.inew] remove ch.frozen.inew
scoreboard players operation @s ch.frozen.zero = #f_dur ch.tmp
scoreboard players set @s ch.frozen.zk 0
effect give @s minecraft:resistance 8 0 true
function ch:kit/frozen/zero/start_fx
return 1
