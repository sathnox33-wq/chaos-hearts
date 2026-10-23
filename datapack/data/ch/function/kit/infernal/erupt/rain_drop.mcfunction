# Releases a molten bomb 14 blocks above its circle.
summon minecraft:block_display ~ ~14 ~ {Tags:["ch.infernal.bomb","ch.noability","ch.infernal.bnew"],teleport_duration:1,brightness:{sky:15,block:15},block_state:{Name:"minecraft:magma_block"},transformation:{left_rotation:[0.2f,0.3f,0.1f,0.926f],right_rotation:[0f,0f,0f,1f],translation:[-0.7f,-0.3f,-0.7f],scale:[1.4f,1.4f,1.4f]}}
scoreboard players operation @e[type=block_display,tag=ch.infernal.bnew,limit=1] ch.owner = @s ch.owner
scoreboard players set @e[type=block_display,tag=ch.infernal.bnew,limit=1] ch.v1 8
scoreboard players set @e[type=block_display,tag=ch.infernal.bnew,limit=1] ch.v6 0
execute if entity @a[tag=ch.caster,scores={ch.awake=1},limit=1] run scoreboard players set @e[type=block_display,tag=ch.infernal.bnew,limit=1] ch.v6 1
tag @e[type=block_display,tag=ch.infernal.bnew] remove ch.infernal.bnew
playsound minecraft:entity.blaze.shoot player @a ~ ~10 ~ 1.2 0.4
