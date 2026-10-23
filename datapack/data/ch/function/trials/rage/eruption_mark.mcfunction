# Marks the five eruption rings and arms one marker per ring (ch.v1 radius, ch.life delay).
summon marker ~ ~ ~ {Tags:["ch.rage.ring","ch.tmob","ch.noability","ch.rage.rnew"]}
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.v1 3
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.life 24
tag @e[type=marker,tag=ch.rage.rnew] remove ch.rage.rnew
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:6.0,s1:6.0,t:2,life:26,spin:0,dy:0.0}
summon marker ~ ~ ~ {Tags:["ch.rage.ring","ch.tmob","ch.noability","ch.rage.rnew"]}
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.v1 6
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.life 29
tag @e[type=marker,tag=ch.rage.rnew] remove ch.rage.rnew
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:12.0,s1:12.0,t:2,life:31,spin:0,dy:0.0}
summon marker ~ ~ ~ {Tags:["ch.rage.ring","ch.tmob","ch.noability","ch.rage.rnew"]}
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.v1 9
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.life 34
tag @e[type=marker,tag=ch.rage.rnew] remove ch.rage.rnew
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:18.0,s1:18.0,t:2,life:36,spin:0,dy:0.0}
summon marker ~ ~ ~ {Tags:["ch.rage.ring","ch.tmob","ch.noability","ch.rage.rnew"]}
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.v1 12
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.life 39
tag @e[type=marker,tag=ch.rage.rnew] remove ch.rage.rnew
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:24.0,s1:24.0,t:2,life:41,spin:0,dy:0.0}
summon marker ~ ~ ~ {Tags:["ch.rage.ring","ch.tmob","ch.noability","ch.rage.rnew"]}
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.v1 15
scoreboard players set @e[type=marker,tag=ch.rage.rnew,limit=1] ch.life 44
tag @e[type=marker,tag=ch.rage.rnew] remove ch.rage.rnew
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:30.0,s1:30.0,t:2,life:46,spin:0,dy:0.0}
