# The transformation: a pillar of fire, a shockwave that hurls enemies back, and the burning followers (orbs, halo, rune, wings).
scoreboard players set @s ch.infernal.av 200
scoreboard players set @s ch.infernal.avk 0
effect give @s minecraft:speed 2 0 true
execute if score @s ch.infernal.avm matches 1 run effect give @s minecraft:levitation 1 4 true
execute if score @s ch.infernal.avm matches 1 run effect give @s minecraft:slow_falling 11 0 true
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5] run function ch:api/push {s:0.9,y:0.4}
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
$particle $(fl) ~ ~1 ~ 0.6 1.2 0.6 0.25 160
particle minecraft:lava ~ ~1 ~ 0.6 0.6 0.6 0 24
$function ch:api/fx/pillar {model:"flame",color:$(c),w:3.0,h:9.0,t:5,life:16}
$function ch:api/fx/pillar {model:"beam",color:$(c3),w:1.2,h:20.0,t:3,life:12}
$execute rotated 0 0 run function ch:api/fx/wave {color:$(c),r:6.0,t:7}
$function ch:api/fx/orb {color:$(c3),s:5.0,t:4,life:9}
$function ch:api/fx/sprite {model:"star",color:$(c),s0:1.0,s1:9.0,t:5,life:9,spin:170,dy:1.0}
$function ch:api/fx/sprite {model:"swirl",color:$(c2),s0:2.0,s1:10.0,t:10,life:14,spin:170,dy:3.0}
$function ch:api/fx/screen {o:"infernal",color:"$(hex)",in:2,stay:8,out:16}
function ch:api/fx/light {t:10}
function ch:api/fx/shake {s:3,t:12,r:16}
playsound chaoshearts:infernal_avatar player @a ~ ~ ~ 2 1
playsound minecraft:entity.ghast.scream player @a ~ ~ ~ 0.8 0.6
playsound minecraft:entity.blaze.ambient player @a ~ ~ ~ 1.5 0.5
title @s subtitle {text:"🔥 INFERNO AVATAR 🔥",color:"#FF7A1A",bold:true}
title @s title {text:""}
$summon minecraft:item_display ~ ~1 ~ {Tags:["ch.infernal.fol","ch.infernal.fnew","ch.noability"],teleport_duration:2,brightness:{sky:15,block:15},view_range:2.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.45f,0.45f,0.45f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/orb","minecraft:custom_model_data":{colors:[$(c3)]}}}}
scoreboard players set @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.v1 0
scoreboard players operation @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.owner = @s ch.pid
tag @e[type=item_display,tag=ch.infernal.fnew] remove ch.infernal.fnew
$summon minecraft:item_display ~ ~1 ~ {Tags:["ch.infernal.fol","ch.infernal.fnew","ch.noability"],teleport_duration:2,brightness:{sky:15,block:15},view_range:2.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.4f,0.4f,0.4f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/orb","minecraft:custom_model_data":{colors:[$(c)]}}}}
scoreboard players set @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.v1 1
scoreboard players operation @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.owner = @s ch.pid
tag @e[type=item_display,tag=ch.infernal.fnew] remove ch.infernal.fnew
$summon minecraft:item_display ~ ~1 ~ {Tags:["ch.infernal.fol","ch.infernal.fnew","ch.noability"],teleport_duration:2,brightness:{sky:15,block:15},view_range:2.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.35f,0.35f,0.35f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/orb","minecraft:custom_model_data":{colors:[$(c3)]}}}}
scoreboard players set @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.v1 2
scoreboard players operation @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.owner = @s ch.pid
tag @e[type=item_display,tag=ch.infernal.fnew] remove ch.infernal.fnew
$summon minecraft:item_display ~ ~1 ~ {Tags:["ch.infernal.fol","ch.infernal.fnew","ch.noability"],teleport_duration:2,brightness:{sky:15,block:15},view_range:2.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2.6f,2.6f,2.6f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/rune","minecraft:custom_model_data":{colors:[$(c)]}}}}
scoreboard players set @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.v1 3
scoreboard players operation @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.owner = @s ch.pid
tag @e[type=item_display,tag=ch.infernal.fnew] remove ch.infernal.fnew
$summon minecraft:item_display ~ ~1 ~ {Tags:["ch.infernal.fol","ch.infernal.fnew","ch.noability"],teleport_duration:2,brightness:{sky:15,block:15},view_range:2.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.9f,0.9f,0.9f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/ring","minecraft:custom_model_data":{colors:[$(c3)]}}}}
scoreboard players set @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.v1 4
scoreboard players operation @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.owner = @s ch.pid
tag @e[type=item_display,tag=ch.infernal.fnew] remove ch.infernal.fnew
$summon minecraft:item_display ~ ~1 ~ {Tags:["ch.infernal.fol","ch.infernal.fnew","ch.noability"],teleport_duration:2,brightness:{sky:15,block:15},view_range:2.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.7f,2.2f,0.7f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/flame","minecraft:custom_model_data":{colors:[$(c)]}}}}
scoreboard players set @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.v1 5
scoreboard players operation @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.owner = @s ch.pid
tag @e[type=item_display,tag=ch.infernal.fnew] remove ch.infernal.fnew
$summon minecraft:item_display ~ ~1 ~ {Tags:["ch.infernal.fol","ch.infernal.fnew","ch.noability"],teleport_duration:2,brightness:{sky:15,block:15},view_range:2.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.7f,2.2f,0.7f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/flame","minecraft:custom_model_data":{colors:[$(c)]}}}}
scoreboard players set @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.v1 6
scoreboard players operation @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.owner = @s ch.pid
tag @e[type=item_display,tag=ch.infernal.fnew] remove ch.infernal.fnew
$summon minecraft:item_display ~ ~1 ~ {Tags:["ch.infernal.fol","ch.infernal.fnew","ch.noability"],teleport_duration:2,brightness:{sky:15,block:15},view_range:2.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[3.2f,3.2f,3.2f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/swirl","minecraft:custom_model_data":{colors:[$(c2)]}}}}
scoreboard players set @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.v1 7
scoreboard players operation @e[type=item_display,tag=ch.infernal.fnew,limit=1] ch.owner = @s ch.pid
tag @e[type=item_display,tag=ch.infernal.fnew] remove ch.infernal.fnew
