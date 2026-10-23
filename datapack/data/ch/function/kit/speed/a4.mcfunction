# Time Fracture. Level: a stasis field where you stand. Up: Chrono Collapse, a smaller field that implodes and
# charges every caught enemy the time they spent inside. Down: Moment Shell, the field rides with you.
execute store result score #hp ch.speed.g run data get entity @s Health 1
scoreboard players operation #fm ch.speed.g = #var ch.tmp
scoreboard players set #fd ch.speed.g 120
scoreboard players set #fr ch.speed.g 12
execute if score #fm ch.speed.g matches 1 run scoreboard players set #fd ch.speed.g 60
execute if score #fm ch.speed.g matches 1 run scoreboard players set #fr ch.speed.g 9
execute if score #fm ch.speed.g matches 2 run scoreboard players set #fd ch.speed.g 100
execute if score #fm ch.speed.g matches 2 run scoreboard players set #fr ch.speed.g 7
execute if score @s ch.b3 matches 3.. run scoreboard players operation #fd ch.speed.g *= #c13 ch.speed.g
execute if score @s ch.b3 matches 3.. run scoreboard players operation #fd ch.speed.g /= #c10 ch.speed.g
execute if score @s ch.b3 matches 4.. run scoreboard players operation #fr ch.speed.g *= #c5 ch.speed.g
execute if score @s ch.b3 matches 4.. run scoreboard players operation #fr ch.speed.g /= #c4 ch.speed.g
summon minecraft:marker ~ ~0.1 ~ {Tags:["ch.speed.frac","ch.noability","ch.speed.fnew"]}
summon minecraft:marker ~ ~ ~ {Tags:["ch.speed.anchor","ch.noability","ch.speed.fnew"]}
scoreboard players operation @e[type=marker,tag=ch.speed.fnew] ch.owner = @s ch.pid
scoreboard players operation @e[type=marker,tag=ch.speed.fnew] ch.life = #fd ch.speed.g
scoreboard players operation @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.frac] ch.v1 = #fr ch.speed.g
scoreboard players operation @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.frac] ch.v2 = #fm ch.speed.g
scoreboard players operation @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.frac] ch.v3 = #hp ch.speed.g
scoreboard players set @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.frac] ch.v4 0
scoreboard players operation @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.frac] ch.v5 = #fd ch.speed.g
scoreboard players set @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.frac] ch.v6 0
execute if score @s ch.b3 matches 5.. run scoreboard players set @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.frac] ch.v6 1
scoreboard players add @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.anchor] ch.life 40
scoreboard players operation #s ch.speed.g = #fd ch.speed.g
scoreboard players add #s ch.speed.g 19
scoreboard players operation #s ch.speed.g /= #20 ch.g
execute store result storage ch:kspeed fx.s int 1 run scoreboard players get #s ch.speed.g
execute store result storage ch:kspeed fx.r int 1 run scoreboard players get #fr ch.speed.g
execute store result storage ch:kspeed fx.d float 2 run scoreboard players get #fr ch.speed.g
execute store result storage ch:kspeed fx.rr float 0.85 run scoreboard players get #fr ch.speed.g
execute store result storage ch:kspeed fx.r6 float 0.6 run scoreboard players get #fr ch.speed.g
execute store result storage ch:kspeed fx.r3 float 0.3 run scoreboard players get #fr ch.speed.g
execute store result storage ch:kspeed fx.life int 1 run scoreboard players get #fd ch.speed.g
execute at @e[type=marker,tag=ch.speed.fnew,tag=ch.speed.frac,limit=1] run function ch:kit/speed/frac/cast_fx with storage ch:kspeed fx
tag @e[type=marker,tag=ch.speed.fnew] remove ch.speed.fnew
function ch:kit/speed/frac/self with storage ch:kspeed fx
function ch:api/fx/screen {o:"flash",color:"#9BEFFF",in:0,stay:2,out:14}
execute if score #fm ch.speed.g matches 0 run title @s subtitle {text:"⌛ Time stands still",color:"#29D3F2",bold:true}
execute if score #fm ch.speed.g matches 1 run title @s subtitle {text:"⌛ Chrono Collapse",color:"#29D3F2",bold:true}
execute if score #fm ch.speed.g matches 2 run title @s subtitle {text:"⌛ Moment Shell",color:"#29D3F2",bold:true}
return 1
