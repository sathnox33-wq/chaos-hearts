# Warlord's Banner (Warlord capstone): War Cry plants a burning war banner for 8 s. Teammates within 5 regenerate,
# enemies within 5 are weakened.
summon marker ~ ~ ~ {Tags:["ch.rage.ban","ch.rage.bnew","ch.noability"]}
scoreboard players set @e[type=marker,tag=ch.rage.bnew,limit=1] ch.life 160
scoreboard players operation @e[type=marker,tag=ch.rage.bnew,limit=1] ch.owner = @s ch.pid
summon item_display ~ ~1.6 ~ {Tags:["ch.rage.deco","ch.rage.bnew","ch.noability"],brightness:{sky:15,block:15},item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2.2f,3.2f,2.2f]},item:{id:"minecraft:red_banner",count:1,components:{"minecraft:banner_patterns":[{pattern:"minecraft:skull",color:"black"},{pattern:"minecraft:border",color:"orange"},{pattern:"minecraft:gradient",color:"black"}]}}}
summon item_display ~ ~3.6 ~ {Tags:["ch.rage.deco","ch.rage.bnew","ch.noability"],brightness:{sky:15,block:15},item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.2f,1.6f,1.2f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/flame","minecraft:custom_model_data":{colors:[16738847]}}}}
summon item_display ~ ~0.08 ~ {Tags:["ch.rage.deco","ch.rage.bnew","ch.noability"],brightness:{sky:15,block:15},item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[10f,1f,10f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/ring_soft","minecraft:custom_model_data":{colors:[16756768]}}}}
scoreboard players set @e[tag=ch.rage.bnew,type=item_display] ch.life 160
tag @e[tag=ch.rage.bnew] remove ch.rage.bnew
function ch:api/fx/pillar {model:"beam",color:16756768,w:0.6,h:7.0,t:4,life:10}
function ch:api/fx/wave {color:16756768,r:5.0,t:6}
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.2 ~ 0.5 0.1 0.5 0.2 20
playsound minecraft:item.armor.equip_netherite player @a ~ ~ ~ 1 0.6
playsound minecraft:block.anvil.land player @a ~ ~ ~ 0.6 0.6
