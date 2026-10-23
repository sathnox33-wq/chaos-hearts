# A lava geyser will burst here in 1.5 s.
summon marker ~ ~ ~ {Tags:["ch.rage.gey","ch.tmob","ch.noability"]}
scoreboard players set @e[type=marker,tag=ch.rage.gey,distance=..0.5,limit=1] ch.life 30
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16738847,s0:0.5,s1:4.0,t:30,life:32,spin:0,dy:0.0}
playsound minecraft:block.lava.ambient master @a[distance=..90] ~ ~ ~ 2 0.6
