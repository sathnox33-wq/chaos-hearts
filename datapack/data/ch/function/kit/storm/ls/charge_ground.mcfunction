# Thunder God: the strike leaves charged ground for 2 seconds.
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.cg","ch.noability","ch.storm.cgnew"]}
scoreboard players operation @e[type=marker,tag=ch.storm.cgnew,limit=1] ch.owner = @a[tag=ch.caster,limit=1] ch.pid
scoreboard players set @e[type=marker,tag=ch.storm.cgnew,limit=1] ch.life 40
tag @e[type=marker,tag=ch.storm.cgnew] remove ch.storm.cgnew
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:5220607,s0:0.5,s1:5.0,t:4,life:40,spin:170,dy:0.0}
