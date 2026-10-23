# One block of a streak: a white trace and a mine.
scoreboard players add #sn ch.speed.g 1
particle minecraft:dust{color:[1.0,1.0,1.0],scale:1.0} ~ ~0.4 ~ 0.1 0.1 0.1 0 3
function ch:api/later {t:20,then:"ch:trials/speed/b/mine"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:trials/speed/b/cfg
execute if score #sn ch.speed.g matches 40.. run return 0
execute if entity @e[type=marker,tag=ch.speed.pt,distance=..1.2,limit=1] run return 0
execute positioned ^ ^ ^1 run function ch:trials/speed/b/seg_step
