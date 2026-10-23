# Glacial Implosion: a frost ring 9 blocks out collapses onto you over 1 s, dragging enemies; then a nova that freezes for 2 s.
summon minecraft:marker ~ ~ ~ {Tags:["ch.frozen.imp","ch.noability","ch.frozen.inew"]}
scoreboard players operation @e[type=marker,tag=ch.frozen.inew,limit=1] ch.owner = @s ch.pid
scoreboard players set @e[type=marker,tag=ch.frozen.inew,limit=1] ch.life 20
tag @e[type=marker,tag=ch.frozen.inew] remove ch.frozen.inew
execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"ring",color:10217471,s0:18.0,s1:1.0,t:20,life:22,spin:170,dy:0.0}
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"rune",color:3108776,s0:18.0,s1:18.0,t:20,life:22,spin:-170,dy:0.0}
playsound minecraft:block.beacon.activate player @a ~ ~ ~ 1.2 1.6
playsound chaoshearts:frozen_blizzard player @a ~ ~ ~ 1 1.6
effect give @s minecraft:resistance 1 1 true
return 1
