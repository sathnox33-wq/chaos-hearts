# Summons the orb (an item display of a black orb) facing the caster's look.
summon item_display ~ ~ ~ {Tags:["ch.void.orb","ch.noability","ch.void.onew"],teleport_duration:1,brightness:{sky:15,block:15},view_range:4.0f,item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.1f,0.1f,0.1f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/orb","minecraft:custom_model_data":{colors:[655380]}}}}
tp @e[type=item_display,tag=ch.void.onew,limit=1] ~ ~ ~ ~ ~
execute as @e[type=item_display,tag=ch.void.onew,limit=1] run function ch:kit/void/orb/init
