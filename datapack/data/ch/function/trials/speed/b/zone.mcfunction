# One clock field (8 seconds).
summon minecraft:marker ~ ~ ~ {Tags:["ch.speed.zone","ch.tmob","ch.noability"]}
scoreboard players set @e[type=marker,tag=ch.speed.zone,distance=..1,limit=1,sort=nearest] ch.life 160
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:2741234,s0:0.5,s1:8.0,t:8,life:160,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16113986,s0:0.5,s1:5.0,t:10,life:160,spin:-170,dy:0.0}
playsound minecraft:block.beacon.ambient master @a[distance=..40] ~ ~ ~ 1 2
