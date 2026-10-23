# The shadow of the falling moon (1.5 s warning) and the moon itself, coming down from 30 blocks.
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"disc",color:2818054,s0:1.0,s1:11.0,t:30,life:32,spin:0,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16723263,s0:11.0,s1:11.0,t:2,life:32,spin:90,dy:0.0}
execute positioned ~ ~0.12 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:10357535,s0:2.0,s1:9.0,t:30,life:32,spin:-170,dy:0.0}
summon item_display ~ ~30 ~ {Tags:["ch.blood.mfall","ch.blood.mnew","ch.noability"],brightness:{sky:15,block:15},item_display:"none",teleport_duration:1,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[5f,5f,5f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/orb","minecraft:custom_model_data":{colors:[10357535]}}}}
scoreboard players set @e[type=item_display,tag=ch.blood.mnew,limit=1] ch.life 30
scoreboard players operation @e[type=item_display,tag=ch.blood.mnew,limit=1] ch.owner = @a[tag=ch.caster,limit=1] ch.pid
tag @e[tag=ch.blood.mnew] remove ch.blood.mnew
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 1.5 0.8
