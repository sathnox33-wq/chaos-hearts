# As the caster: one shard projectile for #f_dmg that may hit #f_pc targets, turned #f_yaw degrees.
function ch:api/proj {item:"minecraft:ice",scale:0.5,speed:9,life:28,hit:"ch:kit/frozen/shard/hit",step:"ch:kit/frozen/shard/step",end:"ch:kit/frozen/shard/end",pierce:1,ignore:"ch.powner"}
tag @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.frozen.p,distance=..4,sort=nearest,limit=1] add ch.frozen.np
tag @e[type=item_display,tag=ch.frozen.np] add ch.frozen.p
scoreboard players operation @e[type=item_display,tag=ch.frozen.np,limit=1] ch.v2 = #f_dmg ch.tmp
scoreboard players operation @e[type=item_display,tag=ch.frozen.np,limit=1] ch.v3 = #f_pc ch.tmp
execute as @e[type=item_display,tag=ch.frozen.np,limit=1] run data merge entity @s {transformation:{left_rotation:{axis:[1f,0f,0f],angle:1.5708f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,-0.8f],scale:[0.35f,1.6f,0.35f]},item:{components:{"minecraft:item_model":"chaoshearts:fx/spike","minecraft:custom_model_data":{colors:[10217471]}}}}
execute if score #f_yaw ch.tmp matches -9 as @e[type=item_display,tag=ch.frozen.np,limit=1] at @s run tp @s ~ ~ ~ ~-9 ~
execute if score #f_yaw ch.tmp matches 9 as @e[type=item_display,tag=ch.frozen.np,limit=1] at @s run tp @s ~ ~ ~ ~9 ~
tag @e[type=item_display,tag=ch.frozen.np] remove ch.frozen.np
tag @e[type=item_display,tag=ch.lnew] remove ch.lnew
