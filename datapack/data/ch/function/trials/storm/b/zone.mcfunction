# One static zone (10 seconds).
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.zone","ch.tmob","ch.noability"]}
scoreboard players set @e[type=marker,tag=ch.storm.zone,distance=..1,limit=1,sort=nearest] ch.life 200
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:5220607,s0:0.5,s1:7.0,t:8,life:200,spin:170,dy:0.0}
playsound minecraft:block.conduit.ambient master @a[distance=..40] ~ ~ ~ 1 2
