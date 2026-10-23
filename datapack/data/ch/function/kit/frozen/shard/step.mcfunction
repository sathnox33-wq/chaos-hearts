# Ice Shard, down: Frost Step. A gust throws you backward; an ice decoy left behind bursts 14 ticks later.
summon minecraft:block_display ~ ~ ~ {Tags:["ch.fx","ch.noability","ch.frozen.dnew"],brightness:{sky:15,block:13},block_state:{Name:"minecraft:ice"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.35f,0f,-0.35f],scale:[0.7f,1.85f,0.7f]}}
scoreboard players set @e[type=block_display,tag=ch.frozen.dnew,limit=1] ch.life 17
tag @e[type=block_display,tag=ch.frozen.dnew] remove ch.frozen.dnew
scoreboard players set #fx ch.g 1
execute positioned ~ ~2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"star",color:10217471,s0:0.2,s1:1.0,t:6,life:16,spin:170,dy:0.0}
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:6273256,s0:0.3,s1:2.0,t:14,life:16,spin:0,dy:0.0}
particle minecraft:snowflake ~ ~1 ~ 0.3 0.6 0.3 0.05 30
playsound minecraft:block.glass.place player @a ~ ~ ~ 1 0.8
playsound minecraft:entity.breeze.wind_burst player @a ~ ~ ~ 0.8 1.4
function ch:api/later {t:14,then:"ch:kit/frozen/shard/decoy_boom"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute rotated ~180 0 run function ch:api/push_player
return 1
