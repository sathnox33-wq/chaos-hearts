# Releases a meteor 18 blocks up.
summon minecraft:block_display ~ ~18 ~ {Tags:["ch.tmob","ch.noability","ch.infernal.tmet","ch.infernal.mnew"],teleport_duration:1,brightness:{sky:15,block:15},block_state:{Name:"minecraft:magma_block"},transformation:{left_rotation:[0.2f,0.3f,0.1f,0.926f],right_rotation:[0f,0f,0f,1f],translation:[-1f,-0.5f,-1f],scale:[2f,2f,2f]}}
scoreboard players set @e[type=block_display,tag=ch.infernal.mnew,limit=1] ch.v1 9
tag @e[type=block_display,tag=ch.infernal.mnew] remove ch.infernal.mnew
playsound minecraft:entity.blaze.shoot master @a[distance=..60] ~ ~14 ~ 1.5 0.4
