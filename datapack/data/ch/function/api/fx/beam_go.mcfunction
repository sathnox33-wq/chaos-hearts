$summon item_display ~ ~ ~ {Tags:["ch.fx","ch.fxnew","ch.noability"],brightness:{sky:15,block:15},view_range:4.0f,interpolation_duration:$(t),item_display:"none",transformation:{left_rotation:{axis:[1f,0f,0f],angle:1.5708f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[$(ax)f,$(ay)f,$(az)f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/$(model)","minecraft:custom_model_data":{colors:[$(color)]},"minecraft:custom_data":{to:{left_rotation:{axis:[1f,0f,0f],angle:1.5708f},right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[$(bx)f,$(by)f,$(bz)f]}}}}}
tp @e[type=item_display,tag=ch.fxnew,limit=1,sort=nearest] ~ ~ ~ ~ ~
$scoreboard players set @e[type=item_display,tag=ch.fxnew,limit=1,sort=nearest] ch.life $(life)
scoreboard players operation @e[type=item_display,tag=ch.fxnew,limit=1,sort=nearest] ch.t = #now ch.g
tag @e[type=item_display,tag=ch.fxnew,limit=1,sort=nearest] add ch.fxwait
tag @e[type=item_display,tag=ch.fxwait] remove ch.fxnew
scoreboard players set #fx ch.g 1
