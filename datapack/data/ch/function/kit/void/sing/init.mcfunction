# As a new singularity marker, caster tagged: snapshot variant, life, radius, damage and Erasure.
tag @s remove ch.void.snew
function ch:api/own
function ch:api/new_eid
scoreboard players operation @s ch.v1 = #vvar ch.tmp
scoreboard players set @s ch.life 120
scoreboard players set @s ch.v2 100
scoreboard players set @s ch.v4 120
execute if entity @a[tag=ch.caster,scores={ch.b2=3..},limit=1] run scoreboard players set @s ch.v2 125
execute if score #vvar ch.tmp matches 1 run scoreboard players operation @s ch.v2 *= #4 ch.g
execute if score #vvar ch.tmp matches 1 run scoreboard players operation @s ch.v2 /= #5 ch.g
execute if score #vvar ch.tmp matches 2 run scoreboard players set @s ch.life 36
execute if score #vvar ch.tmp matches 2 run scoreboard players operation @s ch.v2 *= #6 ch.void.k
execute if score #vvar ch.tmp matches 2 run scoreboard players operation @s ch.v2 /= #5 ch.g
execute if score #vvar ch.tmp matches 2 run scoreboard players set @s ch.v4 140
execute if score #vmini ch.tmp matches 1 run tag @s add ch.void.mini
execute if score #vmini ch.tmp matches 1 run scoreboard players set @s ch.life 50
execute if score #vmini ch.tmp matches 1 run scoreboard players set @s ch.v2 60
execute if score #vmini ch.tmp matches 1 run scoreboard players set @s ch.v4 60
execute store success score @s ch.v6 if entity @a[tag=ch.caster,scores={ch.b3=4..},limit=1]
scoreboard players set @s ch.v3 0
scoreboard players set @s ch.t 0
scoreboard players operation #sid ch.tmp = @s ch.eid
summon item_display ~ ~ ~ {Tags:["ch.void.sd","ch.void.sdn","ch.noability"],teleport_duration:1,brightness:{sky:15,block:15},view_range:6.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.05f,0.05f,0.05f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/orb","minecraft:custom_model_data":{colors:[655380]}}}}
scoreboard players set @e[type=item_display,tag=ch.void.sdn,limit=1] ch.v1 0
function ch:kit/void/sing/link
summon item_display ~ ~ ~ {Tags:["ch.void.sd","ch.void.sdn","ch.noability"],teleport_duration:1,brightness:{sky:15,block:15},view_range:6.0f,item_display:"none",transformation:{left_rotation:{axis:[1f,0f,0f],angle:0.35f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.05f,0.05f,0.05f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/ring","minecraft:custom_model_data":{colors:[9059583]}}}}
scoreboard players set @e[type=item_display,tag=ch.void.sdn,limit=1] ch.v1 1
function ch:kit/void/sing/link
summon item_display ~ ~ ~ {Tags:["ch.void.sd","ch.void.sdn","ch.noability"],teleport_duration:1,brightness:{sky:15,block:15},view_range:6.0f,item_display:"none",transformation:{left_rotation:{axis:[0f,0f,1f],angle:-0.5f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.05f,0.05f,0.05f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/ring_soft","minecraft:custom_model_data":{colors:[13864191]}}}}
scoreboard players set @e[type=item_display,tag=ch.void.sdn,limit=1] ch.v1 2
function ch:kit/void/sing/link
summon item_display ~ ~ ~ {Tags:["ch.void.sd","ch.void.sdn","ch.noability"],teleport_duration:1,brightness:{sky:15,block:15},view_range:6.0f,item_display:"none",transformation:{left_rotation:{axis:[1f,0f,0f],angle:0.35f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.05f,0.05f,0.05f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/swirl","minecraft:custom_model_data":{colors:[1310763]}}}}
scoreboard players set @e[type=item_display,tag=ch.void.sdn,limit=1] ch.v1 3
function ch:kit/void/sing/link
execute if score #vvar ch.tmp matches 2 run function ch:kit/void/sing/telegraph
