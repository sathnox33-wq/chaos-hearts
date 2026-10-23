# The sky splits: $(n) meteors fall around the challenger, 4 ticks apart (each telegraphed for a second).
function ch:trials/infernal/callout {t:"The sky splits... meteors!"}
playsound minecraft:entity.ghast.warn master @a[distance=..90] ~ ~ ~ 2 0.5
particle minecraft:flame ~ ~3 ~ 0.5 1 0.5 0.2 40
$scoreboard players set #in ch.tmp $(n)
execute if score #in ch.tmp matches 1.. run function ch:api/later {t:1,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 1.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 0
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #in ch.tmp matches 2.. run function ch:api/later {t:5,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 2.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 1
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #in ch.tmp matches 3.. run function ch:api/later {t:9,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 3.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 2
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #in ch.tmp matches 4.. run function ch:api/later {t:13,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 4.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 3
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #in ch.tmp matches 5.. run function ch:api/later {t:17,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 5.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 4
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #in ch.tmp matches 6.. run function ch:api/later {t:21,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 6.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 5
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #in ch.tmp matches 7.. run function ch:api/later {t:25,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 7.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 6
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #in ch.tmp matches 8.. run function ch:api/later {t:29,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 8.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 7
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #in ch.tmp matches 9.. run function ch:api/later {t:33,then:"ch:trials/infernal/met_mark"}
execute if score #in ch.tmp matches 9.. run scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 8
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
