# Streak from Vael to the point: a line of mines that detonate 20 ticks later, then Vael is there.
scoreboard players set #sn ch.speed.g 0
execute positioned ~ ~0.6 ~ facing entity @e[type=marker,tag=ch.speed.pt,distance=..80,limit=1] feet run function ch:trials/speed/b/seg_step
execute store result storage ch:tspeed bm.len float 1 run scoreboard players get #sn ch.speed.g
data modify storage ch:tspeed bm.color set value 16113986
data modify storage ch:tspeed bm.w set value 0.5
data modify storage ch:tspeed bm.t set value 2
data modify storage ch:tspeed bm.life set value 22
execute positioned ~ ~1 ~ facing entity @e[type=marker,tag=ch.speed.pt,distance=..80,limit=1] feet run function ch:api/fx/beam with storage ch:tspeed bm
execute if entity @e[type=marker,tag=ch.speed.pt,distance=..80,limit=1] run tp @s @e[type=marker,tag=ch.speed.pt,distance=..80,limit=1]
kill @e[type=marker,tag=ch.speed.pt,distance=..80]
playsound minecraft:entity.breeze.wind_burst master @a[distance=..60] ~ ~ ~ 1 1.6
